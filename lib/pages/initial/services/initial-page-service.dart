import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http/validate-token.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user-model.dart';

Future<User> getUser(String? id) async {
  Dio dio = Dio();
  dio.interceptors.add(TokenInterceptor(dio));
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var url = userUrl + "/" + id!;
  var response = await dio.get(url);
  if (response.statusCode == 200) {
    if (response.data.length > 1) {
      User user = User.fromJson(response.data);
      return user;
    } else {
      return User("", "", 0);
    }
  } else {
    return User("", "", 0);
  }
}

Future<bool> userWithProfile(String? id) async {
  Dio dio = Dio();
  dio.interceptors.add(TokenInterceptor(dio));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool containProfile = false;

  var url = "$userUrl/${id!}/tem-perfil-cadastrado";
  await dio
      .get(url)
      .then((value) => {containProfile = value.data})
      .catchError((e) {
    containProfile = false;
  });

  return containProfile;
}
