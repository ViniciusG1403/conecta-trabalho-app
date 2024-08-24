import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/error-tratament.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/vagas/models/create-vaga-model.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
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
          context, extractErrorMessage(e.response.data["stack"].toString()));
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
          context, extractErrorMessage(e.response.data["stack"].toString()));
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
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }

  getVagasSearch(String value, String query, int distancia, BuildContext context) async {
    if (value == "" && !pesquisarVagasProximas) {
      return getTodasVagas(context);
    } else if (value == "" && pesquisarVagasProximas) {
      return getVagasProximo(20, 80, context);
    }
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    String url;
    if (!pesquisarVagasProximas) {
      url = "$vagasUrl/?search=$query&page=$page&size=20";
    } else {
      url =
          "$vagasUrl/$uuid/proximidade?search=$query&page=$page&size=20&distanciaMaxima=$distancia";
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
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }

  getVagasById(String id) {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    return dio.get("$vagasUrl/$id");
  }

  getVagasByIdEmpresa(String id, BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    String url = "$vagasUrl/empresa/$id";
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
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }

  Future<List<VagasListaResponseModel>> buscarVagasProximas(
      int size, int distancia, BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url =
        "$vagasUrl/$uuid/proximidade?page=1&size=$size&distanciaMaxima=$distancia";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        List<VagasListaResponseModel> vagasEncontradas = [];
        for (var i = 0; i < response.data.length; i++) {
          vagasEncontradas
              .add(VagasListaResponseModel.fromJson(response.data[i]));
        }
        return vagasEncontradas;
      } else {
        throw Exception("Erro ao buscar vagas");
      }
    } catch (e) {
      exibirMensagemErro(context, extractErrorMessage(e.toString()));
      return [];
    }
  }

  
  Future<List<VagasListaResponseModel>> buscarVagasEmpresa(BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('idPerfil')!;
    var url =
        "$vagasUrl/empresa/$uuid";
    try {
      var response = await dio.get(url);
      if (response.statusCode == 200) {
        List<VagasListaResponseModel> vagasEncontradas = [];
        for (var i = 0; i < response.data.length; i++) {
          vagasEncontradas
              .add(VagasListaResponseModel.fromJson(response.data[i]));
        }
        return vagasEncontradas;
      } else {
        throw Exception("Erro ao buscar vagas");
      }
    } catch (e) {
      exibirMensagemErro(context, extractErrorMessage(e.toString()));
      return [];
    }
  }

  cadastrarVaga(VagaCreateRequestModel model, BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('idPerfil')!;
    var url = vagasUrl;
    String modelJson = json.encode(model.toJson());

  await dio.post(url, data: modelJson).then((response) {
    if (response.statusCode == 200) {
      exibirMensagemSucesso(context, "Vaga criada com sucesso");
    }
  }).catchError((e) {
    exibirMensagemErro(
        context, extractErrorMessage(e.response.data["stack"].toString()));
  });
}
}



