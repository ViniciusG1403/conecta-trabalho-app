import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/login/models/resend-activecode-model.dart';
import 'package:conectatrabalho/pages/initial/models/user-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login-model.dart';

Future<String> RealizarLogin(String email, String senha) async {
  Login login = Login(email, senha);

  var url = Uri.parse(loginUrl);
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(login.toJson()));
  if (response.statusCode == 401) {
    return response.body;
  }

  if (response.statusCode != 200) {
    return "Ocorreu um erro ao realizar login";
  }

  try {
    await _saveToken(response.body);
    routes.go("/initial-page");
    return "Login realizado com sucesso";
  } catch (e) {
    return "Ocorreu um erro ao realizar login";
  }
}

Future<void> _saveToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> parsedToken = json.decode(token);
  String tokenTransformed = parsedToken['token'];
  prefs.setString('accessToken', tokenTransformed);
  getInfoFromToken(tokenTransformed);
}

Future<void> getInfoFromToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwtToken = token;

  List<String> tokenParts = jwtToken.split('.');

  if (tokenParts.length != 3) {
    print("Token inválido");
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

Future<String> ResendActivationCode(String email) async {
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
    return "Ocorreu um erro ao reenviar o código de ativação";
  }

  try {
    return "Código reenviado com sucesso";
  } catch (e) {
    return "Ocorreu um erro ao reenviar o código de ativação";
  }
}
