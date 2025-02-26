import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/vagas/enums/situacao-vaga.enum.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:flutter/material.dart';

class HomePageEmpresa extends StatefulWidget {
  const HomePageEmpresa({Key? key}) : super(key: key);

  @override
  State<HomePageEmpresa> createState() => _HomePageEmpresaState();
}

class _HomePageEmpresaState extends State<HomePageEmpresa> {
  late VagasRepository vagasRepository;
  final loading = ValueNotifier(true);
  bool isCharging = false;
  List<VagasListaResponseModel> vagasCharged = [];

  @override
  void initState() {
    vagasRepository = VagasRepository();
    loadingVagas();
    super.initState();
  }

  loadingVagas() async {
    try {
      isCharging = true;
      vagasCharged = await vagasRepository.buscarVagasEmpresa(context);
      setState(() {});
    } catch (e) {
      exibirMensagemErro(context, "Erro ao carregar vagas.");
    } finally {
      isCharging = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Column(children: [
      SizedBox(
        width: screenSize.width * 0.90,
        height: screenSize.height * 0.75,
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          const Text("Suas vagas cadastradas",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Expanded(
            child: isCharging
                ? const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      final vaga = vagasCharged[index];
                      return GestureDetector(
                        onDoubleTap: () async {
                          await _showVagaOptionsModal(
                              context, vaga.id, vagasRepository, vaga.status);
                        },
                        child: Card(
                          color: Colors.transparent,
                          child: ListTile(
                            title: Text(
                              vaga.cargo.length > 20
                                  ? '${vaga.cargo.substring(0, 20)}...'
                                  : vaga.cargo,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 248, 248, 248)),
                            ),
                            subtitle: Text(
                              vaga.descricao.length > 50
                                  ? '${vaga.descricao.substring(0, 30)}...\nSituação:${SituacaoVaga.values[vaga.status].name}'
                                  : '${vaga.descricao}\nSituação: ${SituacaoVaga.values[vaga.status].name}',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 248, 248, 248)),
                            ),
                            trailing: const Icon(
                              Icons.task_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: vagasCharged.length,
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () => routes.go('/vagas'),
                icon: const Icon(
                  Icons.more,
                  color: Colors.white,
                ),
                label: const Text(
                  'Ver mais   ',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ]),
      ),
      const SizedBox(height: 15),
    ]);
  }
}

Future<void> _showVagaOptionsModal(
    BuildContext context, String vagaId, VagasRepository repository, int status) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      List<Widget> actions = [];

      if (status == 0) {
        actions.add(
          TextButton(
            onPressed: () {
              repository.finalizarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Finalizar Vaga'),
          ),
        );
        actions.add(
          TextButton(
            onPressed: () {
              repository.pausarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Pausar Vaga'),
          ),
        );
        actions.add(
          TextButton(
            onPressed: () {
              repository.ativarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Ativar Vaga'),
          ),
        );
      } else if (status == 1) {
        actions.add(
          TextButton(
            onPressed: () {
              repository.finalizarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Finalizar Vaga'),
          ),
        );
        actions.add(
          TextButton(
            onPressed: () {
              repository.pausarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Pausar Vaga'),
          ),
        );
      } else if (status == 2) {
        actions.add(
          TextButton(
            onPressed: () {
              repository.finalizarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Finalizar Vaga'),
          ),
        );
        actions.add(
          TextButton(
            onPressed: () {
              repository.ativarVaga(vagaId, context);
              Navigator.of(context).pop();
            },
            child: const Text('Ativar Vaga'),
          ),
        );
      }

      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            routes.go('/vagas/$vagaId/aplicacoes');
          },
          child: const Text('Ver Aplicações'),
        ),
      );
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
      );

      return AlertDialog(
        title: const Text('Opções da Vaga'),
        content: const Text('Escolha uma das opções abaixo:'),
        actions: actions,
      );
    },
  );
}
