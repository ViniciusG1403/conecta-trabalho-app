import 'dart:async';

import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/empresas/candidato/repositories/empresas-candidato.repository.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/searchBarConectaTrabalho.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

class EmpresasCandidatoPage extends StatefulWidget {
  const EmpresasCandidatoPage({Key? key}) : super(key: key);

  @override
  State<EmpresasCandidatoPage> createState() => _EmpresasCandidatoPageState();
}

class _EmpresasCandidatoPageState extends State<EmpresasCandidatoPage> {
  late EmpresasCandidatoRepository repository;
  List<String> recentSearches = [];
  late SearchController controller;
  bool pesquisarVagasProximas = false;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScroll);
    repository = EmpresasCandidatoRepository();
    loadingVagas();
    super.initState();
  }

  infiniteScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        loading.value == false) {
      loadingVagas();
    }
  }

  loadingVagas() async {
    loading.value = true;
    await repository.getTodasEmpresas(context);
    loading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/initial-page/background-initial-page.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const SizedBox(width: 35),
                IconButton(
                    onPressed: () => routes.go('/home'),
                    icon: const Icon(Icons.arrow_back, color: Colors.white)),
                const SizedBox(width: 230),
                const CustomPopupMenu()
              ],
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: screenSize.width * 0.9,
              child: searchBarEmpresas(screenSize, 1, recentSearches,
                  repository, context),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: AnimatedBuilder(
                  animation: repository,
                  builder: (context, snapshot) {
                    return Stack(children: [
                      ListView.builder(
                          controller: _scrollController,
                          itemBuilder: ((context, index) {
                            final empresa = repository.empresas[index];
                            return GestureDetector(
                                onTap: () =>
                                    routes.go('/empresa/${empresa.id}/completo'),
                                child: Card(
                                    color: Color.fromARGB(160, 33, 0, 109),
                                    child: ListTile(
                                      title: Text(
                                        empresa.nome.length > 30
                                            ? '${empresa.nome.substring(0, 30)}...'
                                            : empresa.nome,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 248, 248, 248)),
                                      ),
                                      subtitle: Text(
                                        empresa.descricao.length > 50
                                            ? '${empresa.descricao.substring(0, 50)}...\n${empresa.setor}\n${empresa.cidadeEstado}'
                                            : '${empresa.descricao}\n${empresa.setor}\n${empresa.cidadeEstado}',
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 248, 248, 248)),
                                      ),
                                      trailing: const Icon(
                                        Icons.task_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    )));
                          }),
                          itemCount: repository.empresas.length)
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
