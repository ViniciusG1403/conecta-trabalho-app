import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/error-tratament.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/candidatos/candidato-lista-response-model.dart';
import 'package:conectatrabalho/pages/candidatos/candidato-response-model.dart';
import 'package:conectatrabalho/pages/empresas/models/empresas-lista-response-model.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CandidatoRepository extends ChangeNotifier {
  int page = 1;
  final List<CandidatoListaResponseModel> candidatos = [];

  getTodosCandidatos(BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url = "$candidatoUrl/?page=$page&size=20";
    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          candidatos
              .add(CandidatoListaResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }

  getCandidato(BuildContext context, String searchOption, String option) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url = "$candidatoUrl/?page=$page&size=20";

    if (searchOption == "") {
      url = "$candidatoUrl/?page=$page&size=20";
    } else if (searchOption == "Nome") {
      url = "$candidatoUrl/?search=usuario.nome:$option&page=$page&size=20";
    } else if (searchOption == "Cidade") {
      url =
          "$candidatoUrl/?search=usuario.endereco.municipio:$option&page=$page&size=20";
    } else if (searchOption == "Habilidades") {
      url = "$candidatoUrl/?search=habilidades:$option&page=$page&size=20";
    }

    if (option == "") {
      url = "$candidatoUrl/?page=$page&size=20";
    }

    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        candidatos.clear();
        for (var i = 0; i < response.data.length; i++) {
          candidatos
              .add(CandidatoListaResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }


}

  Future<CandidatoResponse> getCandidatoById(BuildContext context, String idCandidato) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url = "$candidatoUrl/$idCandidato";
      CandidatoResponse candidato =  CandidatoResponse(
      nome: "",
      email: "",
      telefone: "",
      habilidades: "",
      linkedin: "",
      github: "",
      portfolio: "",
      disponibilidade: "",
      pretensaoSalarial: 0.0,
      endereco: EnderecoDTO(municipio: "", estado: ""));


    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        candidato = CandidatoResponse.fromJson(response.data);
      }
      
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
    return candidato;
  }
