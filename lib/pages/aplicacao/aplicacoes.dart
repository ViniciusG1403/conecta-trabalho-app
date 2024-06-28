import 'dart:async';

import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/aplicacao/repositorios/aplicacao-repository.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/searchBarConectaTrabalho.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

class AplicacoesPage extends StatefulWidget {
  const AplicacoesPage({Key? key}) : super(key: key);

  @override
  State<AplicacoesPage> createState() => _AplicacoesPageState();
}

class _AplicacoesPageState extends State<AplicacoesPage> {
  late AplicacaoRepository repository;
  List<String> recentSearches = [];
  late SearchController controller;
  bool pesquisarVagasProximas = false;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  RangeValues _currentRangeValues = const RangeValues(0, 80);
  String distanciaSelected = "Distancia máxima: 80 km	";

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScroll);
    repository = AplicacaoRepository();
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
    await repository.getAplicacoesByIdCandidato(context);
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
                            final aplicacao = repository.vagas[index];
                            return GestureDetector(
                                child: Card(
                                    color: Color.fromARGB(160, 33, 0, 109),
                                    child: ListTile(
                                      title: Text(
                                        'Empresa: ${aplicacao.nomeEmpresa}\nData da aplicação: ${aplicacao.dataAplicacao.toIso8601String()}\n${aplicacao.statusAplicacao}', style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: const Icon(
                                        Icons.task_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    )));
                          }),
                          itemCount: repository.vagas.length)
                    ]);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
