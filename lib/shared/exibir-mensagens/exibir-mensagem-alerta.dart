import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> exibirMensagemAlerta(
    BuildContext context, String mensagemErro) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagemErro,
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
      backgroundColor: Color.fromARGB(255, 255, 247, 0),
    ),
  );
}
