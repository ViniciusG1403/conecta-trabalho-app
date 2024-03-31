import 'package:conectatrabalho/core/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> salvarImagemCandidato(XFile image, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString('idPerfil')!;

  var url = Uri.parse("$candidatoUrl/salvar-imagem");
  var request = http.MultipartRequest('POST', url);
  request.headers
      .addAll({"Authorization": "Bearer ${prefs.getString('accessToken')}"});
  request.files.add(await http.MultipartFile.fromPath('file', image.path));
  request.files.add(http.MultipartFile.fromString('id', id));
  http.StreamedResponse requestReturn = await request.send();
}
