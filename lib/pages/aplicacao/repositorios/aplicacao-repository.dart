import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/error-tratament.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/aplicacao/models/aplicacoes-model.dart';
import 'package:conectatrabalho/pages/aplicacao/models/aplicar-para-vaga-model.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

aplicarParaVaga(BuildContext context, String idVaga) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idCandidato = prefs.getString("idPerfil");
  dio.interceptors.add(TokenInterceptor(dio));
  final model = AplicarParaVagaModel(idVaga, idCandidato);

  var url = "$aplicacaoUrl/aplicar";
  await dio.post(url, data: json.encode(model.toJson())).then((response) {
    if (response.statusCode == 201) {
      exibirMensagemSucesso(context, "Aplicação realizada com sucesso.");
    }
  }).catchError((e) {
    exibirMensagemErro(
        context, extractErrorMessage(e.response.data["stack"].toString()));
  });
}

cancelarAplicacao(BuildContext context, String idVaga) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idCandidato = prefs.getString("idPerfil");
  dio.interceptors.add(TokenInterceptor(dio));
  final model = AplicarParaVagaModel(idVaga, idCandidato);

  var url = "$aplicacaoUrl/cancelar";
  await dio.post(url, data: json.encode(model.toJson())).then((response) {
    if (response.statusCode == 200) {
      exibirMensagemSucesso(context, "Cancelamento realizada com sucesso.");
    }
  }).catchError((e) {
    exibirMensagemErro(
        context, extractErrorMessage(e.response.data["stack"].toString()));
  });
}

Future<bool> verificarAplicacaoVaga(BuildContext context, String idVaga) async {
  try {
    final dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idCandidato = prefs.getString("idPerfil");
    dio.interceptors.add(TokenInterceptor(dio));
    bool aplicacao = false;

    var url = "$vagasUrl/$idVaga/$idCandidato/verifica-duplicidade-aplicacao";
    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        aplicacao = response.data;
      } else {
        aplicacao = false;
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
      aplicacao = false;
    });
    return aplicacao;
  } catch (e) {
    exibirMensagemErro(context, extractErrorMessage(e.toString()));
    return false;
  }
}


class AplicacaoRepository extends ChangeNotifier {
  int page = 1;
  final List<AplicacaoDetailResponseModel> vagas = [];
  bool pesquisarVagasProximas = true;

  getAplicacoesByIdCandidato(BuildContext context) async {
    final dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idCandidato = prefs.getString("idPerfil");
    dio.interceptors.add(TokenInterceptor(dio));

    var url = "$aplicacaoUrl/$idCandidato/candidato";

    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          vagas.add(AplicacaoDetailResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }


Future<AplicacaoCompletaModel> getAplicacaoById(
    BuildContext context, String idAplicacao) async {
  final dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idCandidato = prefs.getString("idPerfil");
  dio.interceptors.add(TokenInterceptor(dio));
  AplicacaoCompletaModel aplicacao = AplicacaoCompletaModel("", "", "", DateTime.now(), "", 0, "", "");

  var url = "$aplicacaoUrl/$idAplicacao";
  await dio.get(url).then((response) {
    if (response.statusCode == 200) {
      aplicacao = AplicacaoCompletaModel.fromJson(response.data);
    }
  }).catchError((e) {
    exibirMensagemErro(
        context, extractErrorMessage(e.response.data["stack"].toString()));
  });
  return aplicacao;
}
}
