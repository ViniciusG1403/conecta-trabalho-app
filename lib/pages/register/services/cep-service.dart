import 'dart:convert';
import 'package:conectatrabalho/pages/register/models/cep-model.dart';
import 'package:http/http.dart' as http;
import 'package:conectatrabalho/core/environment.dart';

Future<Cep> getCep(String? cep) async {
  var url = Uri.parse("$viaCepUrl${cep!}/json");
  var response = await http.get(url);
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.length > 1) {
      Cep cep = Cep.fromJson(jsonResponse);
      return cep;
    } else {
      return Cep("", "", "", "", "", "", "", "", "", "");
    }
  } else {
    return Cep("", "", "", "", "", "", "", "", "", "");
    ;
  }
}
