import 'package:conectatrabalho/core/routes.dart';
import 'package:flutter/material.dart';

void showRegisterSuccesfullModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Usuário registrado com sucesso'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Foi enviado um código para o seu email, será solicitado no seu primeiro login.'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Voltar a tela inicial'),
            onPressed: () {
              routes.go("/");
            },
          ),
        ],
      );
    },
  );
}
