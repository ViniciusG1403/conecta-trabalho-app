import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/register/models/active-user-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login-model.dart';

Future<String> ActiveUser(code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ActiveUserModel activeUserModel = ActiveUserModel(code);

  var url = Uri.parse(activeUserUrl);
  var response = await http.put(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(activeUserModel.toJson()));
  if (response.statusCode == 401) {
    return response.body ?? "Ocorreu um erro ao ativar o usuário";
  }

  if (response.statusCode != 200) {
    return response.body ?? "Ocorreu um erro ao ativar o usuário";
  } else {
    return "Usuário ativado com sucesso";
  }
}
