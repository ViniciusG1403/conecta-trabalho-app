import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/initial/services/initial-page-service.dart';
import 'package:conectatrabalho/pages/login/models/resend-activecode-model.dart';
import 'package:conectatrabalho/pages/initial/models/user-model.dart';
import 'package:conectatrabalho/pages/shared/exibir-mensagens/exibir-mensagem-alerta.dart';
import 'package:conectatrabalho/pages/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
import 'package:conectatrabalho/pages/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login-model.dart';

Future<String> RealizarLogin(
    String email, String senha, BuildContext context) async {
  Login login = Login(email, senha);

  var url = Uri.parse("$authUrl/login");
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(login.toJson()));
  if (response.statusCode == 401) {
    exibirMensagemAlerta(context, response.body);
    return response.body;
  }

  if (response.statusCode != 200) {
    exibirMensagemErro(context, "Ocorreu um erro ao realizar login");
    return "Ocorreu um erro ao realizar login";
  }

  try {
    await _saveToken(response.body, context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('uidUsuario');
    bool userProfile = await userWithProfile(idUser!);

    if (userProfile) {
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
}

Future<void> _saveToken(String token, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> parsedToken = json.decode(token);
  String tokenTransformed = parsedToken['token'];
  prefs.setString('accessToken', tokenTransformed);
  getInfoFromToken(tokenTransformed, context);
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

Future<String> ResendActivationCode(String email, BuildContext context) async {
  ResendActivateCode model =
      ResendActivateCode("", "Ativação de usuário", email);

  var url = Uri.parse(userUrl + "/reenviar-codigo");
  var response = await http.put(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(model.toJson()));
  if (response.statusCode == 401) {
    return response.body;
  }

  if (response.statusCode != 200) {
    exibirMensagemErro(
        context, "Ocorreu um erro ao reenviar o código de ativação");
    return "Ocorreu um erro ao reenviar o código de ativação";
  }

  try {
    exibirMensagemSucesso(context, "Código reenviado com sucesso");
    return "Código reenviado com sucesso";
  } catch (e) {
    exibirMensagemErro(
        context, "Ocorreu um erro ao reenviar o código de ativação");
    return "Ocorreu um erro ao reenviar o código de ativação";
  }
}
