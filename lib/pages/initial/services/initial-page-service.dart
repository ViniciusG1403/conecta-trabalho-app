import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/initial/models/perfil-model.dart';
import 'package:conectatrabalho/pages/register/perfil-candidato-registro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  if(containProfile){
    getProfile().then((value) {
      prefs.setString("idPerfil", value.id);
      prefs.setInt("tipoUsuario", value.tipoUsuario);


    });
  }

  return containProfile;
}

Future<Perfil> getProfile() async {
  Dio dio = Dio();
  dio.interceptors.add(TokenInterceptor(dio));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool containProfile = false;

  String? idUser = prefs.getString('uidUsuario');
  Perfil perfil = Perfil("", "", "", 0, "");

  var url = "$userUrl/${idUser!}/perfil";
  DateTime now = DateTime.now();
  await dio
      .get(url)
      .then((value) => {
            perfil = Perfil.fromJson(value.data),
            prefs.setString("idPerfil", perfil.id),
            prefs.setInt("tipoUsuario", perfil.tipoUsuario),
            prefs.setString("fotoPerfil", perfil.fotoPerfil),
            prefs.setInt("timeFoto", now.millisecondsSinceEpoch),
            containProfile = true
          })
      .catchError((e) {
    containProfile = false;
  });

  return perfil;
}
