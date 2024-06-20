import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/aplicacao/repositorios/aplicacao-repository.dart';
import 'package:conectatrabalho/pages/vagas/models/vaga-detail-response-model.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:flutter/material.dart';

class DetalhesVagaPage extends StatefulWidget {
  DetalhesVagaPage({Key? key, required this.id}) : super(key: key);
  final String? id;

  @override
  State<DetalhesVagaPage> createState() => _DetalhesVagaPageState();
}

class _DetalhesVagaPageState extends State<DetalhesVagaPage> {
  final VagasRepository _vagasRepository = VagasRepository();
  VagasDetailResponseModel response =
      VagasDetailResponseModel("", "", "", "", 0, "", "", 0.0);
        bool jaAplicado = false;

  @override
  void initState() {
    verifyApplication();
    loadVaga();
    super.initState();
  }

  loadVaga() async {
    await _vagasRepository.getVagasById(widget.id!).then((value) {
      setState(() {
        response = VagasDetailResponseModel.fromJson(value.data);
      });
    });
  }

  verifyApplication(){
  verificarAplicacaoVaga(context, widget.id!).then((value) {
    setState(() {
      jaAplicado = value;
    });
  });
  }

  @override
  void dispose() {
    super.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(width: 35),
                  IconButton(
                      onPressed: () => routes.go('/vagas'),
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const Spacer(),
                  const CustomPopupMenu(),
                  const SizedBox(width: 35),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Detalhes da vaga",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                width: screenSize.width * 0.95,
                child: Card(
                  color: const Color.fromARGB(89, 135, 135, 135),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Empresa: ${response.empresa}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Cargo: ${response.cargo}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          response.remuneracao == 0
                              ? 'Remuneração: A combinar'
                              : 'Remuneração: R\$ ${response.remuneracao}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Descrição detalhada da vaga:',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: screenSize.width * 0.95,
                child: Card(
                  color: const Color.fromARGB(89, 135, 135, 135),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          '${response.descricao}\n',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => {
                  jaAplicado ? {} : aplicarParaVaga(context, response.id),
                  setState(() {
                    jaAplicado = true;
                  })
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.black)),
                icon: jaAplicado ? const Icon(Icons.check, color: Colors.green,) : const Icon(Icons.check, color: Colors.white,),
                label: jaAplicado ? const Text('Já aplicado', style: TextStyle(color: Colors.white),) : const Text('Candidatar-se', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
