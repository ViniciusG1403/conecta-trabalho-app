import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/aplicacao/enums/situacao-aplicacao.enum.dart';
import 'package:conectatrabalho/pages/aplicacao/modal/feedback-aplicacao-modal.dart';
import 'package:conectatrabalho/pages/aplicacao/models/aplicacoes-model.dart';
import 'package:conectatrabalho/pages/aplicacao/repositorios/aplicacao-repository.dart';
import 'package:conectatrabalho/pages/candidatos/show-candidato-modal.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

bool isCharging = false;

Future<AplicacaoCompletaModel> loadAplicacao(
    BuildContext context, String id) async {
  try {
    isCharging = true;
    final repository = AplicacaoRepository();
    AplicacaoCompletaModel aplicacao =
        await repository.getAplicacaoById(context, id);
    return aplicacao;
  } catch (e) {
    exibirMensagemErro(context, "Ocorreu um erro ao carregar a aplicação");
    return AplicacaoCompletaModel("", "", "", DateTime.now(), "", 1, "", "", "");
  } finally {
    isCharging = false;
  }
}

void showModalDetalhesAplicacaoEmpresa(
    BuildContext context, String id, VoidCallback onClose) async {
  Size screenSize = MediaQuery.of(context).size;
  AplicacaoCompletaModel aplicacao = await loadAplicacao(context, id);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 39, 7, 114),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Detalhes da aplicação',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: isCharging
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Data da aplicação: ${DateFormat('dd/MM/yyyy hh:mm').format(aplicacao.dataAplicacao)}",
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Situação: ${SituacaoAplicacao.values[aplicacao.statusAplicacao].name}",
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Vaga: ${aplicacao.tituloVaga}",
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Empresa: ${aplicacao.nomeEmpresa}",
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Feedback da empresa: ${aplicacao.feedbackEmpresa}",
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                        "Feedback do candidato: ${aplicacao.feedbackCandidato} ",
                        style: const TextStyle(color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () => showModalFeedback(context, id),
                          label: const Text("Feedback", style: TextStyle(color: Colors.white),),
                          icon: const Icon(Icons.feedback, color: Colors.white,),
                        ),
                          TextButton.icon(
                          onPressed: () => showModalDetalhesCandidato(context, aplicacao.idCandidato),
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Ver candidato",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () => {
                            routes.go('/detalhes-vaga/${aplicacao.idVaga}'),
                            Navigator.of(context).pop()
                          },
                          icon: const Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                          label: const Text("Vaga",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      );
    },
  );
}
