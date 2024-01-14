import 'package:conectatrabalho/pages/register/archives/termos-uso.dart';
import 'package:flutter/material.dart';

Future<bool> showTermsAndCondition(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible:
            true, // Permite que o diálogo seja fechado ao tocar fora dele
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.of(context).pop(
                  false); // Retorna false quando o diálogo é fechado de outra forma
              return false;
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: const Color(0xff220A55),
              title: const Text(
                'Termos e condições de uso',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: Colors.white),
                    Text(
                      termosDeUso,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Alinha os botões horizontalmente
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(false), // Retorna false
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                          ),
                          child: const Text(
                            "Recusar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.of(context).pop(true), // Retorna true
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                return Colors.white;
                              },
                            ),
                          ),
                          child: const Text(
                            "Aceitar",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ) ??
      false; // Retorna false como valor padrão se o diálogo for fechado de outra forma
}
