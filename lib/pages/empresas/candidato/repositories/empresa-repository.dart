import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/error-tratament.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/empresas/models/empresa-response-model.dart';
import 'package:conectatrabalho/pages/empresas/models/empresas-lista-response-model.dart';
import 'package:conectatrabalho/pages/empresas/models/empresas-lista-response-model.dart';
import 'package:conectatrabalho/pages/empresas/perfil/perfil-empresa-edicao-model.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpresaRepository extends ChangeNotifier {
  int page = 1;
  final List<EmpresasListaResponseModel> empresas = [];

  getTodasEmpresas(BuildContext context) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url = "$empresaUrl/?page=$page&size=20";
    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        for (var i = 0; i < response.data.length; i++) {
          empresas.add(EmpresasListaResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }

  getEmpresasNome(
      String pesquisa, BuildContext context, String searchOption) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;

    String url;

    if (pesquisa == "") {
      url = "$empresaUrl/?page=$page&size=20";
    } else if (searchOption == 'Nome Empresa') {
      url = "$empresaUrl/?search=usuario.nome:$pesquisa&page=$page&size=20";
    } else if (searchOption == 'Cidade') {
      url =
          "$empresaUrl/?search=usuario.endereco.municipio:$pesquisa&page=$page&size=20";
    } else if (searchOption == 'Setor') {
      url = "$empresaUrl/?search=setor:$pesquisa&page=$page&size=20";
    } else {
      url = "$empresaUrl/?page=$page&size=20";
    }

    await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        empresas.clear();
        for (var i = 0; i < response.data.length; i++) {
          empresas.add(EmpresasListaResponseModel.fromJson(response.data[i]));
        }
        page++;
        notifyListeners();
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }

  Future<EmpresaReponseModel> getEmpresaCompleto(
      BuildContext context, String id) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;

    String url = "$empresaUrl/${id}";

    return await dio.get(url).then((response) {
      if (response.statusCode == 200) {
        return EmpresaReponseModel.fromJson(response.data);
      } else {
        return EmpresaReponseModel("", "", "", "", "", "", "", "", "");
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
      return EmpresaReponseModel("", "", "", "", "", "", "", "", "");
    });
  }

  updatePerfilEmpresa(
      BuildContext context, PerfilEmpresaEdicaoModel perfil) async {
    final dio = Dio();
    dio.interceptors.add(TokenInterceptor(dio));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = "$empresaUrl";

    await dio.put(url, data: json.encode(perfil.toJson())).then((response) {
      if (response.statusCode == 200) {
        exibirMensagemSucesso(context, "Perfil atualizado");
      } else {
        exibirMensagemErro(context, "Erro ao atualizar perfil");
      }
    }).catchError((e) {
      exibirMensagemErro(
          context, extractErrorMessage(e.response.data["stack"].toString()));
    });
  }
}
