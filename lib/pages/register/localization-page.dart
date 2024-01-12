import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:conectatrabalho/pages/register/modals/register-succesfull-modal.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/services/register-service.dart';

class LocalizationPage extends StatefulWidget {
  const LocalizationPage({super.key, required this.user});
  final User user;

  @override
  State<LocalizationPage> createState() => _LocalizationPageState();
}

class _LocalizationPageState extends State<LocalizationPage> {
  late TextEditingController _cepController;
  late TextEditingController _streetController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _numberController;
  late TextEditingController _complementController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isCharging = false;
  ValueNotifier<String> responseNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _cepController = TextEditingController();
    _streetController = TextEditingController();
    _neighborhoodController = TextEditingController();
    _numberController = TextEditingController();
    _complementController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
  }

  Future<String> toModel() async {
    if (!_formKey.currentState!.validate()) {
      return 'Por favor, preencha todos os campos obrigatórios';
    }

    setState(() {
      _isCharging = true;
    });

    UserRegister userRegister = UserRegister(
        widget.user.name,
        widget.user.email,
        widget.user.password,
        widget.user.type,
        Localization(
            _cepController.text,
            _streetController.text,
            _numberController.text,
            _complementController.text,
            _neighborhoodController.text,
            _cityController.text,
            _stateController.text));

    String response = await RegistrarUsuario(userRegister);

    setState(() {
      _isCharging = false;
    });

    return response;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
              onPressed: () => context.go("/"),
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
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  _buildTextField(
                      _cepController, 'CEP', 'Por favor, insira o CEP'),
                  const SizedBox(height: 25),
                  _buildTextField(
                      _streetController, 'Rua', 'Por favor, insira a rua'),
                  const SizedBox(height: 25),
                  _buildTextField(_neighborhoodController, 'Bairro',
                      'Por favor, insira o bairro'),
                  const SizedBox(height: 25),
                  _buildTextField(_numberController, 'Número',
                      'Por favor, insira o número'),
                  const SizedBox(height: 25),
                  _buildTextField(_complementController, 'Complemento', null),
                  const SizedBox(height: 25),
                  _buildTextField(
                      _cityController, 'Cidade', 'Por favor, insira a cidade'),
                  const SizedBox(height: 25),
                  _buildTextField(
                      _stateController, 'Estado', 'Por favor, insira o estado'),
                  const SizedBox(height: 40),
                  ValueListenableBuilder<String>(
                    valueListenable: responseNotifier,
                    builder: (context, value, _) {
                      return Text(value,
                          style: const TextStyle(color: Colors.white));
                    },
                  ),
                  _buildSaveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String? errorMessage) {
    return SizedBox(
      width: 330,
      height: 50,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        validator: errorMessage == null
            ? null
            : (value) {
                if (value == null || value.isEmpty) {
                  return errorMessage;
                }
                return null;
              },
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      child: _isCharging
          ? const CircularProgressIndicator(color: Colors.black)
          : OutlinedButton(
              onPressed: () async {
                String response = await toModel();
                if (response == "Cadastro realizado com sucesso") {
                  showRegisterSuccesfullModal(context);
                } else {
                  responseNotifier.value = response;
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
              child:
                  const Text("Salvar", style: TextStyle(color: Colors.black)),
            ),
    );
  }
}
