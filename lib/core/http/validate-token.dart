import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/routes.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;

  TokenInterceptor(this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool tokenValido = await validateToken();

    if (!tokenValido) {
      await atualizarToken();
      tokenValido = await validateToken();
    }

    if (!tokenValido) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      routes.go('/');
    }

    SharedPreferences.getInstance().then((prefs) {
      options.headers['Authorization'] =
          'Bearer ${prefs.getString('accessToken')}';
      handler.next(options);
    });
  }

  Future<bool> validateToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('accessToken')!;
    var url = Uri.parse('$authUrl/validate');
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $accessToken'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> parsedToken = json.decode(token);
    String tokenTransformed = parsedToken['token'];
    prefs.setString('accessToken', tokenTransformed);
  }

  Future<void> atualizarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uidUsuario = prefs.getString('uidUsuario')!;
    var url = Uri.parse("$authUrl/$uidUsuario/refresh");
    var response =
        await http.post(url, headers: {"Content-Type": "application/json"});

    await _saveToken(response.body);
  }
}
