import 'dart:async';

import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/candidatos/candidato-repository.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/searchBarConectaTrabalho.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

class CandidatosPage extends StatefulWidget {
  const CandidatosPage({Key? key}) : super(key: key);

  @override
  State<CandidatosPage> createState() => _CandidatosPageState();
}

class _CandidatosPageState extends State<CandidatosPage> {
  late CandidatoRepository repository;
  List<String> recentSearches = [];
  late SearchController controller;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  String searchOption = 'Descrição';

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScroll);
    repository = CandidatoRepository();
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
    await repository.getTodosCandidatos(context);
    loading.value = false;
  }

  
  void onSearchOptionChanged(String? newOption) {
    if (newOption != null) {
      setState(() {
        searchOption = newOption;
      });
    }
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
                const CustomPopupMenuEmpresa()
              ],
            ),
            const SizedBox(height: 35),
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
                            final vaga = repository.candidatos[index];
                            return GestureDetector(
                                child: Card(
                                    color: Color.fromARGB(160, 33, 0, 109),
                                    child: ListTile(
                                      title: Text(
                                        vaga.nome.length > 30
                                            ? '${vaga.nome.substring(0, 30)}...'
                                            : vaga.nome,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 248, 248, 248)),
                                      ),
                                      subtitle: Text(
                                        vaga.habilidades.length > 50
                                            ? '${vaga.habilidades.substring(0, 50)}'
                                            : vaga.habilidades,
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
                          itemCount: repository.candidatos.length)
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
