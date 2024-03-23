import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorMessage(
    BuildContext context, String mensagemErro) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(mensagemErro, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    ),
  );
}
