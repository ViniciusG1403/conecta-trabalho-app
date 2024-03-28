import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/http-interceptor/token-interceptor.dart';
import 'package:conectatrabalho/pages/home/models/busca-perfil-model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<BuscaPerfilRetorno> getPerfilByUser() async {
  Dio dio = Dio();
  dio.interceptors.add(TokenInterceptor(dio));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uuid = prefs.getString('uidUsuario')!;

  var url = userUrl + "/" + uuid + "/perfil";
  var response = await dio.get(url);
  if (response.statusCode == 200) {
    if (response.data.length > 1) {
      BuscaPerfilRetorno user = BuscaPerfilRetorno.fromJson(response.data);
      return user;
    } else {
      return BuscaPerfilRetorno("", "", "", "");
    }
  } else {
    return BuscaPerfilRetorno("", "", "", "");
  }
}
