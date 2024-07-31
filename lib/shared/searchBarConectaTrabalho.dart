import 'package:conectatrabalho/pages/empresas/candidato/repositories/empresas-candidato.repository.dart';
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

SizedBox searchBarEmpresas(
    Size screenSize,
    EmpresasCandidatoRepository repository,
    BuildContext context,
    String searchOption,
    void Function(String?) onSearchOptionChanged) {
  SearchController controller = SearchController();

  return SizedBox(
    width: screenSize.width * 0.9,
    child: Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0),
            ),
            onChanged: (value) {
              repository.page = 1;
              repository.empresas.clear();
              repository.getEmpresasNome(value, context, searchOption);
            },
            hintText: "Pesquise por $searchOption",
            leading: PopupMenuButton<String>(
              icon: const Icon(
                Icons.search
              ),
              onSelected: onSearchOptionChanged,
              itemBuilder: (BuildContext context) {
                return <String>['Nome Empresa', 'Setor', 'Cidade']
                    .map<PopupMenuItem<String>>((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            ),
            textInputAction: TextInputAction.search,
          ),
        ),
        SizedBox(width: 10),
      ],
    ),
  );
}
