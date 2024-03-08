import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/services/validate-fields-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkerProfileRegisterPage extends StatefulWidget {
  const WorkerProfileRegisterPage({super.key});
  @override
  State<WorkerProfileRegisterPage> createState() =>
      _WorkerProfileRegisterPageState();
}

class _WorkerProfileRegisterPageState extends State<WorkerProfileRegisterPage> {
  late TextEditingController _telefoneController;
  late TextEditingController _professionController;
  late TextEditingController _sectorController;
  late TextEditingController _habilitiesController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _telefoneController = TextEditingController(text: "");
    _professionController = TextEditingController(text: "");
    _sectorController = TextEditingController(text: "");
    _habilitiesController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: const Color(0xff220A55),
            toolbarHeight: 100,
            leadingWidth: 300,
            leading: Row(children: [
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
            ])),
        body: Container(
            width: screenSize.width,
            height: screenSize.height,
            decoration: const BoxDecoration(
              color: Color(0xff220A55),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.8,
                    child: const Text(
                      "Aqui você preencherá o seu perfil de trabalhador, não se esqueça de preencher sempre com dados reais para que as empresas consigam entrar em contato com você.",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    child: _buildTextField(_telefoneController, "Nr Telefone",
                        "O número de telefone é obrigatório"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: _buildTextField(_professionController, "Profissão",
                        "A Profissão é obrigatória"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: _buildTextField(
                        _sectorController, "Setor em que trabalha", ""),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    child: _buildTextField(
                        _habilitiesController, "Habilidades", ""),
                  ),
                ]),
              ),
            )));
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String? errorMessage) {
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
