import 'dart:convert';
import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/register/models/perfil-candidato-registro-model.dart';
import 'package:conectatrabalho/pages/register/models/perfil-empresa-registro-model.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> registrarCandidato(Candidato candidato) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  candidato.idUsuario = prefs.getString('uidUsuario') ?? "";

  var url = Uri.parse(candidatoUrl);
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('accessToken')}"
      },
      body: json.encode(candidato.toJson()));

  if (response.statusCode != 201) {
    var jsonResponse = json.decode(response.body);
    var errorMessage = _extractErrorMessage(jsonResponse);
    return errorMessage ??
        "Ocorreu um erro ao preencher o perfil, tente novamente";
  } else {
    return "Preenchimento de perfil realizado com sucesso";
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
    return "Ocorreu um erro ao preencher perfil, tente novamente";
  }
  return null;
}

Future<String> registrarEmpresa(Empresa empresa) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  empresa.idUsuario = prefs.getString('uidUsuario') ?? "";

  var url = Uri.parse(empresaUrl);
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString('accessToken')}"
      },
      body: json.encode(empresa.toJson()));

  if (response.statusCode != 201) {
    var jsonResponse = json.decode(response.body);
    var errorMessage = _extractErrorMessage(jsonResponse);
    return errorMessage ??
        "Ocorreu um erro ao preencher o perfil, tente novamente";
  } else {
    return "Preenchimento de perfil realizado com sucesso";
  }
}
