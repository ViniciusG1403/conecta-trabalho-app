import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:http/http.dart' as http;

Future<String> RegistrarUsuario(UserRegister user) async {
  var url = Uri.parse(userUrl);
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()));

  if (response.statusCode != 200) {
    return "Ocorreu um erro ao cadastrar, tente novamente";
  } else {
    return "Cadastro realizado com sucesso";
  }
}
