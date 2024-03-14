import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/home/models/busca-perfil-model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<BuscaPerfilRetorno> getPerfilByUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uuid = prefs.getString('uidUsuario')!;

  var url = Uri.parse(userUrl + "/" + uuid + "/perfil");
  var response = await http.get(url,
      headers: {"Authorization": "Bearer ${prefs.getString('accessToken')}"});
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.length > 1) {
      BuscaPerfilRetorno user = BuscaPerfilRetorno.fromJson(jsonResponse);
      return user;
    } else {
      return BuscaPerfilRetorno("", "", "", "", []);
    }
  } else {
    return BuscaPerfilRetorno("", "", "", "", []);
  }
}
