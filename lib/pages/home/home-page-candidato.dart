import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

class HomePageCandidato extends StatefulWidget {
  const HomePageCandidato({Key? key}) : super(key: key);

  @override
  State<HomePageCandidato> createState() => _HomePageCandidatoState();
}

class _HomePageCandidatoState extends State<HomePageCandidato> {
  late VagasRepository vagasRepository;
  final loading = ValueNotifier(true);
  List<VagasListaResponseModel> vagasCharged = [];

  @override
  void initState() {
    vagasRepository = VagasRepository();
    loadingVagas();
    super.initState();
  }

  loadingVagas() async {
    vagasCharged = await vagasRepository.buscarVagasProximas(5, 80, context);
    setState(() {
 
    });
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
          const Text("Vagas próximas a você",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final vaga = vagasCharged[index];
                return GestureDetector(
                  onTap: () => routes.go('/detalhes-vaga/${vaga.id}'),
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
                            ? '${vaga.descricao.substring(0, 30)}...\nEmpresa ${vaga.empresa}'
                            : '${vaga.descricao}\nEmpresa ${vaga.empresa}',
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
