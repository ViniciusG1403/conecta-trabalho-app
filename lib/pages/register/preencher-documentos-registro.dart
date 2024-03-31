import 'package:conectatrabalho/pages/register/models/retorno-cadastro-perfil.dart';
import 'package:conectatrabalho/pages/register/services/profiles-service.dart';
import 'package:conectatrabalho/shared/tratamento-documentos-imagens/image-picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PreencherDocumentosRegistro extends StatefulWidget {
  PreencherDocumentosRegistro({Key? key, required this.retorno})
      : super(key: key);
  RetornoCadastroPerfil retorno;
  @override
  State<PreencherDocumentosRegistro> createState() =>
      _PreencherDocumentosRegistroState();
}

class _PreencherDocumentosRegistroState
    extends State<PreencherDocumentosRegistro> {
  final _formKey = GlobalKey<FormState>();

  _filePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

      if (result != null) {
        setState(() {
          salvarCurriculumCandidato(result, widget.retorno.id);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Seleção cancelada pelo usuário",
                style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ocorreu um erro ao selecionar o arquivo",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
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
                  height: screenSize.height * 0.2,
                  child: widget.retorno.tipo == 1
                      ? const Text(
                          "Por favor, selecione uma foto de perfil para sua conta",
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          "Por favor, selecione uma foto de perfil e um currículo para sua conta",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () => imagePickerWithType(
                          widget.retorno.tipo, widget.retorno.id, context),
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
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: screenSize.width * 0.8,
                  child: widget.retorno.tipo == 0
                      ? ElevatedButton(
                          onPressed: () => _filePicker(),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_copy,
                                color: Colors.black,
                              ),
                              Text("  "),
                              Text(
                                "Selecionar currículo",
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ))
                      : const SizedBox(),
                ),
                const SizedBox(height: 100),
                SizedBox(
                    width: screenSize.width * 0.4,
                    child: ElevatedButton(
                      onPressed: () => context.go("/home"),
                      child: const Text("Finalizar cadastro"),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
