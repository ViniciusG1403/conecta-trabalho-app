import 'package:conectatrabalho/pages/register/services/active-user-service.dart';
import 'package:flutter/material.dart';

Future<String> activeUser(String code, BuildContext context) async {
  String response = await ActiveUser(code);
  return response;
}

void showActivationModal(BuildContext context) {
  TextEditingController codeController = TextEditingController();
  ValueNotifier<String> responseNotifier = ValueNotifier('');

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text('Ativação de Usuário'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Foi enviado um código para o seu email cadastrado.'),
            const SizedBox(height: 10),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Código de Ativação',
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: responseNotifier,
              builder: (context, value, _) {
                return Text(value);
              },
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Ativar'),
            onPressed: () async {
              String response = await activeUser(codeController.text, context);
              responseNotifier.value = response;
              if (response == "Usuário ativado com sucesso") {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
