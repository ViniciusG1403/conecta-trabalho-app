import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/empresas/candidato/repositories/empresas-candidato.repository.dart';
import 'package:conectatrabalho/pages/empresas/models/empresa-response-model.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:flutter/material.dart';

class EmpresaCompletaPage extends StatefulWidget {
  EmpresaCompletaPage({Key? key, required this.id}) : super(key: key);
  final String? id;

  @override
  State<EmpresaCompletaPage> createState() => _EmpresaCompletaPageState();
}

class _EmpresaCompletaPageState extends State<EmpresaCompletaPage> {
  final EmpresasCandidatoRepository empresasCandidatoRepository = EmpresasCandidatoRepository();
  EmpresaReponseModel response = EmpresaReponseModel("", "", "", "", "", "", "", "", "");
  bool jaAplicado = false;

  @override
  void initState() {
    loadVaga();
    super.initState();
  }

  loadVaga() async {
    await empresasCandidatoRepository.getEmpresaCompleto(context, widget.id!).then((value) {
      setState(() {
        response = value;
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
            image: AssetImage('assets/images/initial-page/background-initial-page.png'),
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
                    onPressed: () => routes.go('/vagas'),
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
                          title: Text("Nome", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.nome, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("Email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.email, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("Telefone", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.telefone, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("Setor", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.setor, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("Descrição", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.descricao, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("Website", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.website, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("LinkedIn", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.linkedin, style: TextStyle(color: Colors.white)),
                        ),
                        ListTile(
                          title: Text("Endereço", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(response.endereco, style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
