import 'dart:async';

import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/vagas/models/vaga-detail-response-model.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/pages/vagas/models/vagas-lista-response-model.dart';
import 'package:conectatrabalho/shared/searchBarConectaTrabalho.dart';
import 'package:conectatrabalho/pages/vagas/repositorios/vagas_repository.dart';
import 'package:flutter/material.dart';

class DetalhesVagaPage extends StatefulWidget {
  DetalhesVagaPage({Key? key, required this.id}) : super(key: key);
  late String? id;

  @override
  State<DetalhesVagaPage> createState() => _DetalhesVagaPageState();
}

class _DetalhesVagaPageState extends State<DetalhesVagaPage> {
  final VagasRepository _vagasRepository = VagasRepository();
  VagasDetailResponseModel response =
      VagasDetailResponseModel("", "", "", "", 0, "", "", 0.0);
  @override
  void initState() {
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
                const SizedBox(width: 230),
                const CustomPopupMenu()
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
            Card(
                color: const Color.fromARGB(89, 135, 135, 135),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Empresa: ${response.empresa}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Cargo: ${response.cargo}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        response.remuneracao == 0
                            ? 'Remuneração: A combinar'
                            : 'Remuneração: R\$ ${response.remuneracao}',
                        style: const TextStyle(color: Colors.white),
                      )
                    ])),
          ],
        ),
      ),
    );
  }
}
