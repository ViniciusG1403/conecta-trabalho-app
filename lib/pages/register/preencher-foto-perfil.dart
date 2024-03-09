import 'package:conectatrabalho/pages/register/models/retorno-cadastro-perfil.dart';
import 'package:conectatrabalho/pages/register/services/profiles-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PreencherFotoPerfil extends StatefulWidget {
  PreencherFotoPerfil({Key? key, required this.retorno}) : super(key: key);
  RetornoCadastroPerfil retorno;
  @override
  State<PreencherFotoPerfil> createState() => _PreencherFotoPerfilState();
}

class _PreencherFotoPerfilState extends State<PreencherFotoPerfil> {
  final _formKey = GlobalKey<FormState>();

  _imagePicker() async {
    ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && widget.retorno.tipo == 0) {
      salvarImagemCandidato(image, widget.retorno.id);
    }
    if (image != null && widget.retorno.tipo == 1) {
      salvarImagemEmpresa(image, widget.retorno.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff220A55),
        toolbarHeight: 80,
        leadingWidth: 300,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => context.go("/initial-page"),
            ),
            const Text("                      "),
            Image.asset(
              'assets/images/register-page/logo-register.png',
              filterQuality: FilterQuality.high,
              height: 40,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          color: Color(0xff220A55),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: const Text(
                    "Por favor, selecione uma foto de perfil para sua conta",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () => _imagePicker(),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          Text("  "),
                          Text(
                            "Selecionar foto",
                            style: TextStyle(color: Colors.black),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
