import 'dart:ui';

import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/aplicacao/enums/situacao-aplicacao.enum.dart';
import 'package:conectatrabalho/pages/aplicacao/models/aplicacoes-model.dart';
import 'package:conectatrabalho/pages/aplicacao/repositorios/aplicacao-repository.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

void showModalFeedback(BuildContext context, String id) async {
  TextEditingController feedbackController = TextEditingController();
  Size screenSize = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 39, 7, 114),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Feedback da aplicação',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              width: screenSize.width * 0.95,
              height: screenSize.height * 0.3,
              child: TextFormField(
                controller: feedbackController,
                selectionHeightStyle: BoxHeightStyle.tight,
                style: const TextStyle(color: Colors.white),
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Colors.white,
                  labelText: 'Feedback',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
                  labelStyle: TextStyle(color: Colors.white),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async => {
                      await darFeedback(context, id, feedbackController.text),
                      context.pop(),
                    },
                child: Text('Enviar', style: TextStyle(color: Colors.white))),
          ],
        )),
      );
    },
  );
}
