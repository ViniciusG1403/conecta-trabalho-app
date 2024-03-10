import 'package:conectatrabalho/pages/register/models/perfil-candidato-registro-model.dart';
import 'package:conectatrabalho/pages/register/models/perfil-empresa-registro-model.dart';
import 'package:conectatrabalho/pages/register/services/profiles-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/services/validate-fields-service.dart';

class PerfilEmpresaRegistro extends StatefulWidget {
  const PerfilEmpresaRegistro({Key? key}) : super(key: key);

  @override
  State<PerfilEmpresaRegistro> createState() => _PerfilEmpresaRegistroState();
}

class _PerfilEmpresaRegistroState extends State<PerfilEmpresaRegistro> {
  late TextEditingController _setorController;
  late TextEditingController _descricaoController;
  late TextEditingController _websiteController;
  late TextEditingController _linkedinController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _setorController = TextEditingController(text: "");
    _descricaoController = TextEditingController(text: "");
    _websiteController = TextEditingController(text: "");
    _linkedinController = TextEditingController(text: "");
    super.initState();
  }

  void _registerWorkerProfile() {
    if (_formKey.currentState!.validate()) {
      Empresa empresa = Empresa(
          '',
          _setorController.text,
          _descricaoController.text,
          _websiteController.text,
          _linkedinController.text);

      registrarEmpresa(empresa).then((value) {
        if (value.id !=
            "Ocorreu um erro ao preencher perfil, tente novamente") {
          context.go("/preencher-foto", extra: value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value.id),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
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
                    "Aqui você preencherá o seu perfil de empresa, não se esqueça de preencher sempre com dados reais para que os candidatos consigam confiar em sua empresa.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _buildTextField(
                  _setorController,
                  "Setor",
                  false,
                  "Setor é obrigatório",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _descricaoController,
                  "Descrição da Empresa	",
                  false,
                  "Descrição é obrigatória",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _websiteController,
                  "Website",
                  true,
                  "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _linkedinController,
                  "Linkedin",
                  true,
                  "",
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () => _registerWorkerProfile(),
                    child: const Text(
                      "Salvar",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    bool permitNull,
    String? errorMessage,
  ) {
    return SizedBox(
      width: 330,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (permitNull) {
            return null;
          }
          return validateNullField(value, label);
        },
      ),
    );
  }
}
