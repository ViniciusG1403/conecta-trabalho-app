import 'dart:convert';
import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:http/http.dart' as http;

Future<String> registrarUsuario(UserRegister user) async {
  var url = Uri.parse(userUrl);
  var response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()));

  if (response.statusCode != 201) {
    var jsonResponse = json.decode(response.body);
    var errorMessage = _extractErrorMessage(jsonResponse);
    return errorMessage ?? "Ocorreu um erro ao cadastrar, tente novamente";
  } else {
    return "Cadastro realizado com sucesso";
  }
}

String? _extractErrorMessage(Map<String, dynamic> jsonResponse) {
  try {
    String details = jsonResponse['details'];
    var lastIndex = details.lastIndexOf(':');
    if (lastIndex != -1) {
      return details.substring(lastIndex + 1).trim();
    }
  } catch (e) {
    return "Ocorreu um erro ao cadastrar, tente novamente";
  }
  return null;
}
