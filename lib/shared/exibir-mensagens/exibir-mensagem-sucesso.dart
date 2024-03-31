import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> exibirMensagemSucesso(
    BuildContext context, String mensagemErro) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagemErro,
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
      backgroundColor: Color.fromARGB(255, 0, 177, 6),
    ),
  );
}
