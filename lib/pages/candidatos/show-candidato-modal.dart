import 'dart:ui';

import 'package:conectatrabalho/pages/candidatos/candidato-repository.dart';
import 'package:conectatrabalho/pages/candidatos/candidato-response-model.dart';
import 'package:flutter/material.dart';

void showModalDetalhesCandidato(BuildContext context, String id) async {
  CandidatoResponse candidato = await getCandidatoById(context, id);
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 39, 7, 114),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Detalhes do Candidato',
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
              Text('Nome: ${candidato.nome}', style: const TextStyle(color: Colors.white)),
              Text('Email: ${candidato.email}', style: const TextStyle(color: Colors.white)),
              Text('Telefone: ${candidato.telefone}', style: const TextStyle(color: Colors.white)),
              Text('Habilidades: ${candidato.habilidades}', style: const TextStyle(color: Colors.white)),
              Text('LinkedIn: ${candidato.linkedin}', style: const TextStyle(color: Colors.white)),
              Text('GitHub: ${candidato.github}', style: const TextStyle(color: Colors.white)),
              Text('Portfolio: ${candidato.portfolio}', style: const TextStyle(color: Colors.white)),
              Text('Disponibilidade: ${candidato.disponibilidade}', style: const TextStyle(color: Colors.white)),
              Text('Pretensão Salarial: R\$${candidato.pretensaoSalarial.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white)),
              Text('Endereço: ${candidato.endereco.toJson()['endereco']}', style: const TextStyle(color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              TextButton.icon(onPressed: () => downloadCurriculo(context, id), label: Text("Curriculo", style: TextStyle(color: Colors.white),), icon: Icon(Icons.download)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Fechar', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}