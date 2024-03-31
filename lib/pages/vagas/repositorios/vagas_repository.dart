import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VagasRepository extends ChangeNotifier {
  int page = 1;
  final List<VagasListaResponseModel> vagas = [];
  bool pesquisarVagasProximas = true;

  getTodasVagas(BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url = "$vagasUrl/?page=$page&size=20";
    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          vagas.add(VagasListaResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, "Ocorreu um erro ao buscar as vagas, tente novamente.");
    });
  }

  getVagasProximo(int size, int distancia, BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;

    var url =
        "$vagasUrl/$uuid/proximidade?page=$page&size=$size&distanciaMaxima=$distancia";
    dio
        .get(url)
        .then((response) => {
              if (response.statusCode == 200)
                {
                  for (var i = 0; i < response.data.length; i++)
                    {
                      vagas.add(
                          VagasListaResponseModel.fromJson(response.data[i])),
                    },
                  page++,
                  notifyListeners(),
                }
            })
        .catchError((e) {
      exibirMensagemErro(
          context, "Ocorreu um erro ao buscar as vagas, tente novamente.");
    });
  }

  getVagasCargos(String pesquisa, int distancia, BuildContext context) async {
    if (pesquisa == "" && !pesquisarVagasProximas) {
      return getTodasVagas(context);
    } else if (pesquisa == "" && pesquisarVagasProximas) {
      return getVagasProximo(20, 80, context);
    }
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    String url;
    if (!pesquisarVagasProximas) {
      url = "$vagasUrl/?search=cargo:$pesquisa&page=$page&size=20";
    } else {
      url =
          "$vagasUrl/$uuid/proximidade?search=cargo:$pesquisa&page=$page&size=20&distanciaMaxima=$distancia";
    }

    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          vagas.add(VagasListaResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, "Ocorreu um erro ao buscar as vagas, tente novamente.");
    });
  }

  getVagasById(String id) {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    return dio.get("$vagasUrl/$id");
  }
}
