import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

SizedBox searchBarConectaTrabalho(screenSize, page, recentSearches,
    VagasRepository repository, int distancia, BuildContext context) {
  SearchController controller = SearchController();
  return SizedBox(
      width: screenSize.width * 0.9,
      child: SearchBar(
        controller: controller,
        padding: const MaterialStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        onChanged: (value) {
          repository.page = 1;
          repository.vagas.clear();
          repository.getVagasCargos(value, distancia, context);
        },
        hintText: "Pesquise por vagas",
        leading: const Icon(Icons.search),
        textInputAction: TextInputAction.search,
      ));
}
