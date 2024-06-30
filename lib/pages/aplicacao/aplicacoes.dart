import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/aplicacao/enums/situacao-aplicacao.enum.dart';
import 'package:conectatrabalho/pages/aplicacao/modal/detalhes-aplicacao-modal.dart';
import 'package:conectatrabalho/pages/aplicacao/repositorios/aplicacao-repository.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AplicacoesPage extends StatefulWidget {
  const AplicacoesPage({Key? key}) : super(key: key);

  @override
  State<AplicacoesPage> createState() => _AplicacoesPageState();
}

bool isCharging = false;

class _AplicacoesPageState extends State<AplicacoesPage> {
  late AplicacaoRepository repository;
  List<String> recentSearches = [];
  bool pesquisarVagasProximas = false;
  final loading = ValueNotifier(true);
  late final ScrollController _scrollController;
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
    try {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          loading.value == false) {
        loadingVagas();
      }
    } catch (e) {
      exibirMensagemErro(context, "Erro ao carregar vagas.");
    }
  }

  loadingVagas() async {
    try {
      isCharging = true;
      repository.vagas.clear();
      loading.value = true;
      await repository.getAplicacoesByIdCandidato(context);
      loading.value = false;
      setState(() {
        repository.notifyListeners();
      });
    } catch (e) {
      exibirMensagemErro(context, "Erro ao carregar vagas.");
    } finally {
      isCharging = false;
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
        child: isCharging
            ? const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 35),
                      IconButton(
                          onPressed: () => routes.go('/home'),
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white)),
                      const SizedBox(width: 230),
                      const CustomPopupMenu()
                    ],
                  ),
                  const SizedBox(height: 35),
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
                                          color: const Color.fromARGB(
                                              160, 33, 0, 109),
                                          child: ListTile(
                                              title: Text(
                                                'Empresa: ${aplicacao.nomeEmpresa}\nData da aplicação:  ${DateFormat('dd/MM/yyyy hh:mm').format(aplicacao.dataAplicacao)}\nSituação: ${SituacaoAplicacao.values[aplicacao.statusAplicacao].name}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              trailing: IconButton(
                                                  icon: const Icon(
                                                    Icons.summarize_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    showModalDetalhesAplicacao(
                                                        context, aplicacao.id,
                                                        () {
                                                      setState(() {
                                                        loadingVagas();
                                                      });
                                                    });
                                                  }))));
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
