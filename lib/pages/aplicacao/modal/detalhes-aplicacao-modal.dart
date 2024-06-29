import 'package:flutter/material.dart';


void showModalDetalhesAplicacao(BuildContext context, String id) {
  Size screenSize = MediaQuery.of(context).size;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 39, 7, 114),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Detalhes da aplicação',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Data da aplicação: 2021-10-10 00:00:00",
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text("Situação: Pendente", style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text("Vaga: Desenvolvedor Flutter",
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text("Empresa: Empresa Teste",
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text("Feedback da empresa: ",
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              Text("Feedback do candidato: ",
                  style: TextStyle(color: Colors.white)),
              SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                ),
                label: Text(
                  "Cancelar aplicação",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
                            TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_right,
                  color: Colors.white,
                ),
                label: Text(
                  "Ir para vaga",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
