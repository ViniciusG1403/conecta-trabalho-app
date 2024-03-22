import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/home/assets/menu-extensivel.dart';
import 'package:conectatrabalho/pages/home/models/vagas-retorno-model.dart';
import 'package:conectatrabalho/pages/shared/searchBarConectaTrabalho.dart';
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
    await repository.getTodasVagas();
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
              child: searchBarConectaTrabalho(
                  screenSize, 1, recentSearches, repository),
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
                          repository.getVagasProximo(20);
                        } else {
                          repository.vagas.clear();
                          repository.page = 1;
                          repository.getTodasVagas();
                        }
                      });
                    },
                    activeColor: Colors.green,
                  )),
                ],
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                  animation: repository,
                  builder: (context, snapshot) {
                    return Stack(children: [
                      ListView.builder(
                          controller: _scrollController,
                          itemBuilder: ((context, index) {
                            final vaga = repository.vagas[index];
                            return Card(
                                color: Color.fromARGB(160, 33, 0, 109),
                                child: ListTile(
                                  title: Text(
                                    vaga.cargo.length > 30
                                        ? '${vaga.cargo.substring(0, 30)}...'
                                        : vaga.cargo,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 248, 248)),
                                  ),
                                  subtitle: Text(
                                    vaga.descricao.length > 50
                                        ? '${vaga.descricao.substring(0, 50)}...\nEmpresa ${vaga.empresa}'
                                        : '${vaga.descricao}\nEmpresa ${vaga.empresa}',
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 248, 248)),
                                  ),
                                  trailing: const Icon(
                                    Icons.task_alt_outlined,
                                    color: Colors.white,
                                  ),
                                ));
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
