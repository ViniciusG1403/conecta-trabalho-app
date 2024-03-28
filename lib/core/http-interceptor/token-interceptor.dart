import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/routes.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  Dio _dio = Dio();

  TokenInterceptor(this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool tokenValido = await _validateToken();

    if (tokenValido) {
      await _atualizarToken();
      tokenValido = await _validateToken();
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

  Future<bool> _validateToken() async {
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

  Future<void> _salvarToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', token);
  }

  Future<void> _atualizarToken() async {
    CancelToken cancelToken = CancelToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uidUsuario = prefs.getString('uidUsuario')!;
    var url = "$authUrl/$uidUsuario/refresh";
    var response = await _dio.post(url, cancelToken: cancelToken);

    String token = response.data['token'];

    await _salvarToken(token);
  }

  void cancelarRequisicao() {
    _dio.httpClientAdapter.close(force: true);
  }
}
