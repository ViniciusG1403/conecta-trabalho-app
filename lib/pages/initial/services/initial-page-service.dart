import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:http/http.dart' as http;
import '../models/user-model.dart';

Future<User> getUser(String? id) async {
  var url = Uri.parse(userUrl + "/" + id!);
  var response = await http.get(url);
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
