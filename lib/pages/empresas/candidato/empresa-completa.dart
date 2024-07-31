import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/empresas/candidato/repositories/empresas-candidato.repository.dart';
import 'package:conectatrabalho/pages/empresas/models/empresa-response-model.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/shared/searchBarConectaTrabalho.dart';
import 'package:flutter/material.dart';

class EmpresaCompletaPage extends StatefulWidget {
  EmpresaCompletaPage({Key? key, required this.id}) : super(key: key);
  final String? id;

  @override
  State<EmpresaCompletaPage> createState() => _EmpresaCompletaPageState();
}

class _EmpresaCompletaPageState extends State<EmpresaCompletaPage> {
  final EmpresasCandidatoRepository empresasCandidatoRepository =
      EmpresasCandidatoRepository();
  EmpresaReponseModel response =
      EmpresaReponseModel("", "", "", "", "", "", "", "", "");
  bool jaAplicado = false;
  String searchOption = 'Nome Empresa'; // Default search option

  @override
  void initState() {
    loadVaga();
    super.initState();
  }

  loadVaga() async {
    await empresasCandidatoRepository
        .getEmpresaCompleto(context, widget.id!)
        .then((value) {
      setState(() {
        response = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onSearchOptionChanged(String? newOption) {
    if (newOption != null) {
      setState(() {
        searchOption = newOption;
      });
    }
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
              const SizedBox(height: 50),
              Row(
                children: [
                  const SizedBox(width: 35),
                  IconButton(
                    onPressed: () => routes.go('/empresas/candidato'),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const Spacer(),
                  const CustomPopupMenu(),
                  const SizedBox(width: 35),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Detalhes da Empresa",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
                        ListTile(
                          title: const Text("Nome",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.nome,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("Email",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.email,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("Telefone",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.telefone,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("Setor",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.setor,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("Descrição",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.descricao,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("Website",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.website,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("LinkedIn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.linkedin,
                              style: const TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: const Text("Endereço",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(response.endereco,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => routes.go('/empresa/${widget.id}/vagas'),
                    child: const Text("Ver todas as vagas"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
