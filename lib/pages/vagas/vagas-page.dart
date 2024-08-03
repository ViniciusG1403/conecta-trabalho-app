import 'dart:async';

import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/searchBarConectaTrabalho.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

class VagasPage extends StatefulWidget {
  const VagasPage({Key? key}) : super(key: key);

  @override
  State<VagasPage> createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  late VagasRepository repository;
  List<String> recentSearches = [];
  late SearchController controller;
  bool pesquisarVagasProximas = false;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
  RangeValues _currentRangeValues = const RangeValues(0, 80);
  String distanciaSelected = "Distancia máxima: 80 km	";
  String searchOption = 'Descrição';

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScroll);
    repository = VagasRepository();
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
    await repository.getTodasVagas(context);
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
                const CustomPopupMenu()
              ],
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: screenSize.width * 0.9,
              child: searchBarConectaTrabalho(screenSize, repository, context,
                  searchOption, _currentRangeValues.end.toInt(), onSearchOptionChanged),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: screenSize.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Somente vagas próximas',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      child: Switch(
                    value: pesquisarVagasProximas,
                    onChanged: (value) {
                      setState(() {
                        pesquisarVagasProximas = value;
                        repository.pesquisarVagasProximas = value;
                        if (value) {
                          repository.vagas.clear();
                          repository.page = 1;
                          repository.getVagasProximo(20, 80, context);
                        } else {
                          repository.vagas.clear();
                          repository.page = 1;
                          repository.getTodasVagas(context);
                        }
                      });
                    },
                    activeColor: Colors.green,
                  )),
                ],
              ),
            ),
            pesquisarVagasProximas
                ? RangeSlider(
                    values: _currentRangeValues,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                        distanciaSelected =
                            "Distância máxima: ${values.end.toInt()} km";
                      });
                    },
                    onChangeStart: (RangeValues values) {
                      RangeValues valor = RangeValues(0, values.end);
                      setState(() {
                        _currentRangeValues = valor;
                      });
                    },
                    onChangeEnd: (value) => {
                      repository.vagas.clear(),
                      repository.page = 1,
                      repository.getVagasProximo(
                          20, value.end.toInt(), context),
                    },
                    max: 1000,
                  )
                : const SizedBox(),
            pesquisarVagasProximas
                ? Text(
                    distanciaSelected,
                    style: TextStyle(color: Colors.white),
                  )
                : const SizedBox(),
            Expanded(
              child: AnimatedBuilder(
                  animation: repository,
                  builder: (context, snapshot) {
                    return Stack(children: [
                      ListView.builder(
                          controller: _scrollController,
                          itemBuilder: ((context, index) {
                            final vaga = repository.vagas[index];
                            return GestureDetector(
                                onTap: () =>
                                    routes.go('/detalhes-vaga/${vaga.id}'),
                                child: Card(
                                    color: Color.fromARGB(160, 33, 0, 109),
                                    child: ListTile(
                                      title: Text(
                                        vaga.cargo.length > 30
                                            ? '${vaga.cargo.substring(0, 30)}...'
                                            : vaga.cargo,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 248, 248, 248)),
                                      ),
                                      subtitle: Text(
                                        vaga.descricao.length > 50
                                            ? '${vaga.descricao.substring(0, 50)}...\nEmpresa ${vaga.empresa}'
                                            : '${vaga.descricao}\nEmpresa ${vaga.empresa}',
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
