import 'dart:convert';
import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/register/models/perfil-candidato-registro-model.dart';
import 'package:conectatrabalho/pages/register/models/perfil-empresa-registro-model.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/models/retorno-cadastro-perfil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<RetornoCadastroPerfil> registrarCandidato(Candidato candidato) async {
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
    return RetornoCadastroPerfil(
        "Ocorreu um erro ao preencher perfil, tente novamente", 0);
  } else {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return RetornoCadastroPerfil.fromJson(jsonResponse);
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

Future<RetornoCadastroPerfil> registrarEmpresa(Empresa empresa) async {
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
    return RetornoCadastroPerfil(
        "Ocorreu um erro ao preencher perfil, tente novamente", 0);
  } else {
    return RetornoCadastroPerfil.fromJson(json.decode(response.body));
  }
}

Future<void> salvarCurriculumCandidato(FilePickerResult file, String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse("$candidatoUrl/salvar-curriculo");
  var request = http.MultipartRequest('POST', url);
  request.headers
      .addAll({"Authorization": "Bearer ${prefs.getString('accessToken')}"});
  request.files.add(
      await http.MultipartFile.fromPath('file', file.files.single.path ?? ""));
  request.files.add(http.MultipartFile.fromString('id', id));
  await request.send();
}

Future<void> salvarImagemEmpresa(XFile image, String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse("$candidatoUrl/salvar-imagem");
  var request = http.MultipartRequest('POST', url);
  request.headers
      .addAll({"Authorization": "Bearer ${prefs.getString('accessToken')}"});
  request.files.add(await http.MultipartFile.fromPath('file', image.path));
  request.files.add(http.MultipartFile.fromString('id', id));
  await request.send();
}
