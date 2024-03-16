import 'package:conectatrabalho/pages/home/services/home-page-service.dart';
import 'package:flutter/material.dart';

import 'models/vagas-retorno-model.dart';

Column buildHomePageCandidato(Size screenSize) {
  var vagas = getVagasProximo();

  return Column(children: [
    Card(
        color: const Color.fromARGB(70, 69, 69, 69),
        child: SizedBox(
            width: screenSize.width * 0.95,
            height: screenSize.height * 0.60,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Text("Vagas próximas a você",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder<List<VagasRetornoModel>>(
                future: vagas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<VagasRetornoModel>? vagasList = snapshot.data;
                    return Column(
                      children: vagasList!
                          .map((vaga) => SizedBox(
                                width: screenSize.width * 0.9,
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      vaga.titulo, // ou qualquer campo que você deseje exibir
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Text(
                                        '${vaga.descricao.substring(0, 20)}...'),
                                    leading: const Icon(Icons.work),
                                  ),
                                ),
                              ))
                          .toList(),
                    );
                  }
                },
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.more,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Ver mais   ',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ]),
            ]))),
    const SizedBox(height: 15),
  ]);
}
