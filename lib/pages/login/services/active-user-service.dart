import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/login/models/active-user-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> ActiveUser(code) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  ActiveUserModel activeUserModel = ActiveUserModel(code);

  var url = Uri.parse(activeUserUrl + code);
  var response = await http.put(url);
  if (response.statusCode == 401) {
    return "Código de ativação inválido";
  }

  if (response.statusCode != 200) {
    return "Código de ativação inválido";
  } else {
    return "Usuário ativado com sucesso";
  }
}
