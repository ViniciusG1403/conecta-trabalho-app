import 'dart:convert';
import 'package:conectatrabalho/pages/register/models/cep-model.dart';
import 'package:http/http.dart' as http;
import 'package:conectatrabalho/core/environment.dart';

Future<Cep> getCep(String? cep) async {
  var url = Uri.parse(viaCepUrl + cep! + "/json");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    Cep cep = Cep.fromJson(jsonResponse);
    return cep;
  } else {
    return Future.error("CEP inválido");
  }
}
