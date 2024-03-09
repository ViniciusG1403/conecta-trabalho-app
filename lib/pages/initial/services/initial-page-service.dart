import 'dart:convert';
import 'dart:ffi';

import 'package:conectatrabalho/core/environment.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user-model.dart';

Future<User> getUser(String? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var url = Uri.parse(userUrl + "/" + id!);
  var response = await http.get(url,
      headers: {"Authorization": "Bearer ${prefs.getString('accessToken')}"});
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.length > 1) {
      User user = User.fromJson(jsonResponse);
      return user;
    } else {
      return User("", "", 0);
    }
  } else {
    return User("", "", 0);
  }
}

Future<bool> userWithProfile(String? id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var url = Uri.parse("$userUrl/${id!}/tem-perfil-cadastrado");
  var response = await http.get(url,
      headers: {"Authorization": "Bearer ${prefs.getString('accessToken')}"});
  if (response.statusCode == 200) {
    if (response.body == "true") {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
