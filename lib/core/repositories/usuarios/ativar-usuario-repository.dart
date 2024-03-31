import 'dart:convert';

import 'package:conectatrabalho/core/environment.dart';
import 'package:conectatrabalho/core/repositories/usuarios/models/resend-activecode-model.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<String> ActiveUser(code) async {
  Dio _dio = Dio();
  var url = '$userUrl/ativar/$code';
  try {
    var response = await _dio.put(url).timeout(const Duration(seconds: 15));
    if (response.statusCode == 401) {
      return "Código de ativação inválido";
    }

    if (response.statusCode != 200) {
      return "Código de ativação inválido";
    } else {
      return "Usuário ativado com sucesso";
    }
  } catch (e) {
    return "Tempo limite excedido! Tente novamente";
  }
}

Future<String> ResendActivationCode(String email, BuildContext context) async {
  Dio _dio = Dio();
  ResendActivateCode model =
      ResendActivateCode("", "Ativação de usuário", email);

  var url = '$userUrl/reenviar-codigo';
  var response = await _dio.put(url, data: json.encode(model.toJson()));
  if (response.statusCode == 401) {
    return response.data;
  }

  if (response.statusCode != 200) {
    exibirMensagemErro(
        context, "Ocorreu um erro ao reenviar o código de ativação");
    return "Ocorreu um erro ao reenviar o código de ativação";
  }

  try {
    exibirMensagemSucesso(context, "Código reenviado com sucesso");
    return "Código reenviado com sucesso";
  } catch (e) {
    exibirMensagemErro(
        context, "Ocorreu um erro ao reenviar o código de ativação");
    return "Ocorreu um erro ao reenviar o código de ativação";
  }
}
