import 'package:conectatrabalho/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showRegisterSuccessfulModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xff220A55),
        title: const Text(
          'Cadastro realizado com sucesso',
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
            const Divider(color: Colors.white),
            const Text(
              'Foi enviado um código de confirmação para o email informado, o código será solicitado no seu primeiro login no aplicativo.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Caso não tenha recebido o código, verifique sua caixa de spam.',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => {routes.go("/"), context.pop()},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return Colors.white;
                    },
                  ),
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
