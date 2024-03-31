import 'package:conectatrabalho/core/repositories/usuarios/ativar-usuario-repository.dart';
import 'package:conectatrabalho/pages/login/repositories/login-repository.dart';
import 'package:flutter/material.dart';

bool _isCharging = false;
Future<String> activeUser(String code, BuildContext context) async {
  if (code == "") {
    return "Código de ativação não pode ser vazio";
  }

  _isCharging = true;
  String response = await ActiveUser(code);
  return response;
}

Future<String> resendCode(String email, BuildContext context) async {
  _isCharging = true;
  String response = await ResendActivationCode(email, context);
  return response;
}

void showActivationModal(BuildContext context, String email, String senha) {
  TextEditingController codeController = TextEditingController();
  _isCharging = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xff220A55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Ativação de Usuário',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            const Text(
              'Foi enviado um código para o seu email cadastrado.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: codeController,
              maxLength: 6,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusColor: Colors.white,
                labelText: 'Código de Ativação',
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
          ],
        ),
        actions: <Widget>[
          _isCharging
              ? const CircularProgressIndicator()
              : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    child: const Text('Reenviar código',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      String response = await resendCode(email, context);
                      _isCharging = false;
                    },
                  ),
                  TextButton(
                    child: const Text('Ativar',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      String response =
                          await activeUser(codeController.text, context);
                      if (response == "Usuário ativado com sucesso") {
                        Navigator.of(context).pop();
                        RealizarLogin(email, senha, context);
                        _isCharging = false;
                      } else {
                        _isCharging = false;
                      }
                    },
                  )
                ]),
        ],
      );
    },
  );
}
