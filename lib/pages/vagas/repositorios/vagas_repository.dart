import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/pages/home/models/vagas-retorno-model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VagasRepository extends ChangeNotifier {
  int page = 1;
  final List<VagasRetornoModel> vagas = [];
  bool pesquisarVagasProximas = true;

  getTodasVagas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    var url = Uri.parse("$vagasUrl/?page=${page}&size=20");
    var response = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString('accessToken')}"});
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      for (var i = 0; i < jsonResponse.length; i++) {
        vagas.add(VagasRetornoModel.fromJson(jsonResponse[i]));
      }
      page++;
      notifyListeners();
    }
  }

  getVagasProximo(int size, int distancia) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;

    var url = Uri.parse(
        "$vagasUrl/$uuid/proximidade?page=${page}&size=${size}&distanciaMaxima=${distancia}");
    var response = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString('accessToken')}"});
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      for (var i = 0; i < jsonResponse.length; i++) {
        vagas.add(VagasRetornoModel.fromJson(jsonResponse[i]));
      }
      page++;
      notifyListeners();
    }
  }

  getVagasCargos(String pesquisa) async {
    if (pesquisa == "" && !pesquisarVagasProximas) {
      return getTodasVagas();
    } else if (pesquisa == "" && pesquisarVagasProximas) {
      return getVagasProximo(20, 80);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uidUsuario')!;
    Uri url;
    if (!pesquisarVagasProximas) {
      url =
          Uri.parse("$vagasUrl/?search=cargo:${pesquisa}&page=${page}&size=20");
    } else {
      url = Uri.parse(
          "$vagasUrl/$uuid/proximidade?search=cargo:${pesquisa}&page=${page}&size=20");
    }

    var response = await http.get(url,
        headers: {"Authorization": "Bearer ${prefs.getString('accessToken')}"});
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      for (var i = 0; i < jsonResponse.length; i++) {
        vagas.add(VagasRetornoModel.fromJson(jsonResponse[i]));
      }
      page++;
      notifyListeners();
    }
  }
}
