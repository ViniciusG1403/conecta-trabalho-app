import 'package:conectatrabalho/pages/register/models/perfil-candidato-registro-model.dart';
import 'package:conectatrabalho/pages/register/services/profiles-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:go_router/go_router.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/services/validate-fields-service.dart';

class PerfilCandidatoRegistro extends StatefulWidget {
  const PerfilCandidatoRegistro({Key? key}) : super(key: key);

  @override
  State<PerfilCandidatoRegistro> createState() =>
      _PerfilCandidatoRegistroState();
}

class _PerfilCandidatoRegistroState extends State<PerfilCandidatoRegistro> {
  late TextEditingController _habilidadesController;
  late TextEditingController _linkedinController;
  late TextEditingController _githubController;
  late TextEditingController _portfolioController;
  late TextEditingController _disponibilidadeController;
  late TextEditingController _pretensaoSalarialController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _habilidadesController = TextEditingController(text: "");
    _linkedinController = TextEditingController(text: "");
    _githubController = TextEditingController(text: "");
    _portfolioController = TextEditingController(text: "");
    _disponibilidadeController = TextEditingController(text: "");
    _pretensaoSalarialController =
        MaskedTextController(mask: "R\$ 000.000,00'", text: "");
    super.initState();
  }

  void _registerWorkerProfile() {
    if (_formKey.currentState!.validate()) {
      num pretensaoSalarial = num.parse(_pretensaoSalarialController.text
          .replaceAll("R\$", "")
          .replaceAll(".", "")
          .replaceAll(",", ".")
          .replaceAll("'", ""));
      Candidato candidato = Candidato(
          '',
          _habilidadesController.text,
          _linkedinController.text,
          _githubController.text,
          _portfolioController.text,
          _disponibilidadeController.text,
          pretensaoSalarial);

      registrarCandidato(candidato).then((value) {
        if (value == "Preenchimento de perfil realizado com sucesso") {
          context.go("/home");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value),
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
                    "Aqui você preencherá o seu perfil de candidato, não se esqueça de preencher sempre com dados reais para que as empresas consigam entrar em contato com você.",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                _buildTextField(
                  _habilidadesController,
                  "Habilidades",
                  "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _linkedinController,
                  "Linkedin",
                  "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _githubController,
                  "GitHub",
                  "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _portfolioController,
                  "Portfolio",
                  "",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _disponibilidadeController,
                  "Disponibilidade",
                  "A disponibilidade é obrigatória.",
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildTextField(
                  _pretensaoSalarialController,
                  "Pretensão Salarial Mensal",
                  "A pretensão salarial é obrigatória.",
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
          return validateNullField(value, label);
        },
      ),
    );
  }
}
