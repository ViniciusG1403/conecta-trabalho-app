// ignore_for_file: use_build_context_synchronously

import 'package:conectatrabalho/pages/register/services/profiles-service.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:conectatrabalho/shared/tratamento-documentos-imagens/repositories/save-documentos-repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> imagePicker(idUsuario, BuildContext context) async {
  try {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getInt("tipoUsuario")!;
    if (image != null && prefs.getInt("tipoUsuario") == 0) {
      salvarImagemCandidato(image, context);
    }
    if (image != null && prefs.getInt("tipoUsuario") == 1) {
      salvarImagemEmpresa(image, idUsuario);
    }
    if (image == null) {
      exibirMensagemErro(context, "Seleção cancelada pelo usuário");
      return false;
    }

    return true;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Ocorreu um erro ao processar a imagem",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }
}

Future<bool> imagePickerWithType(tipo, idUsuario, BuildContext context) async {
  try {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && tipo == 0) {
      salvarImagemCandidato(image, context);
    }
    if (image != null && tipo == 1) {
      salvarImagemEmpresa(image, idUsuario);
    }
    if (image == null) {
      exibirMensagemErro(context, "Seleção cancelada pelo usuário");
      return false;
    }

    return true;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Ocorreu um erro ao processar a imagem",
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }
}
