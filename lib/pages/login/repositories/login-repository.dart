import 'dart:async';
import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/initial/services/initial-page-service.dart';
import 'package:conectatrabalho/pages/login/modals/active-user-modal.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-alerta.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login-model.dart';

Future<String> RealizarLogin(
    String email, String senha, BuildContext context) async {
  try {
    Login login = Login(email, senha);
    Dio _dio = Dio();
    var url = "$authUrl/login";
    var response = await _dio
        .post(url, data: json.encode(login.toJson()))
        .timeout(const Duration(seconds: 15));
    if (response.statusCode == 401) {
      exibirMensagemAlerta(context, response.data);
      return response.data;
    }

    if (response.statusCode != 200) {
      exibirMensagemErro(context, "Ocorreu um erro ao realizar login");
      return "Ocorreu um erro ao realizar login";
    }

    try {
      await _saveToken(response.data['token'], context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? idUser = prefs.getString('uidUsuario');
      bool userProfile = await userWithProfile(idUser!);

      if (userProfile) {
        await getProfile();
        routes.go("/home");
      } else {
        routes.go("/initial-page");
      }
      exibirMensagemSucesso(context, "Login realizado com sucesso");
      return "Login realizado com sucesso";
    } catch (e) {
      exibirMensagemErro(context, "Ocorreu um erro ao realizar login");
      return "Ocorreu um erro ao realizar login";
    }
  } on TimeoutException catch (e) {
    exibirMensagemErro(
        context, "Tempo limite excedido ao realizar login, tente novamente.");
    return "Ocorreu um erro ao realizar login";
  } catch (e) {
    if(e.toString().contains("inativo")){
      showActivationModal(context, email, senha);
      return " ";
    }
    exibirMensagemErro(context, "Usuário ou senha inválido.");
    return "Ocorreu um erro ao realizar login";
  }
}

Future<void> _saveToken(String token, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', token);
  getInfoFromToken(token, context);
}

Future<void> getInfoFromToken(String token, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwtToken = token;

  List<String> tokenParts = jwtToken.split('.');

  if (tokenParts.length != 3) {
    exibirMensagemErro(context, "Ocorreu um erro ao autenticar o usuário");
  } else {
    String payload = tokenParts[1];

    while (payload.length % 4 != 0) {
      payload += '=';
    }
    String decodedPayload = utf8.decode(base64Url.decode(payload));
    Map<String, dynamic> payloadMap = json.decode(decodedPayload);

    String preferredUsername = payloadMap["preferred_username"];
    List<dynamic> groups = payloadMap["groups"];
    String uidUsuario = payloadMap["aud"];

    prefs.setString('uidUsuario', uidUsuario);
    prefs.setString('username', preferredUsername);
  }
}

Future<String?> _getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  return token;
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('accessToken', '');
  routes.go("/");
}
