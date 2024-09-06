import 'package:conectatrabalho/pages/candidatos/candidato-repository.dart';
import 'package:conectatrabalho/pages/empresas/candidato/repositories/empresa-repository.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

String convertSearchOptionInQuery(String searchOption) {
  switch (searchOption) {
    case 'Descrição':
      return 'descricao:';
    case 'Cargo':
      return 'cargo:';
    case 'Nível':
      return 'nivel:';
    default:
      return 'descricao:';
  }
}

SizedBox searchBarConectaTrabalho(
    Size screenSize,
    VagasRepository repository,
    BuildContext context,
    String searchOption,
    int distancia,
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
              repository.vagas.clear();
              String query = convertSearchOptionInQuery(searchOption) + value;
              repository.getVagasSearch(value, query, distancia, context);
            },
            hintText: "Pesquise por $searchOption",
            leading: PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu,
              ),
              onSelected: onSearchOptionChanged,
              itemBuilder: (BuildContext context) {
                return <String>['Descrição', 'Cargo', 'Nível']
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

SizedBox searchBarEmpresas(
    Size screenSize,
    EmpresaRepository repository,
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
                Icons.menu,
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

SizedBox searchBarCandidato(
    Size screenSize,
    CandidatoRepository repository,
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
              repository.candidatos.clear();
              String query = convertSearchOptionInQuery(searchOption) + value;
              repository.getCandidato(context, searchOption, value);
            },
            hintText: "Pesquise por $searchOption",
            leading: PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu,
              ),
              onSelected: onSearchOptionChanged,
              itemBuilder: (BuildContext context) {
                return <String>['Nome', 'Cidade', 'Habilidades']
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
