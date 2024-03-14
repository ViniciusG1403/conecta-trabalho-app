import 'package:conectatrabalho/pages/register/modals/terms-modal.dart';
import 'package:conectatrabalho/pages/register/models/cep-model.dart';
import 'package:conectatrabalho/pages/register/services/cep-service.dart';
import 'package:conectatrabalho/pages/register/services/validate-fields-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
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
  late TextEditingController _estadoController;
  late TextEditingController _paisController;
  late TextEditingController _municipioController;
  late TextEditingController _bairroController;
  late TextEditingController _logradouroController;
  late TextEditingController _numeroController;
  late TextEditingController _complementoController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isCharging = false;
  ValueNotifier<String> responseNotifier = ValueNotifier('');
  bool _isAceptedTerms = false;

  @override
  void initState() {
    super.initState();
    _cepController = MaskedTextController(text: "", mask: '00000-000');
    _estadoController = TextEditingController();
    _paisController = TextEditingController(text: "Brasil");
    _municipioController = TextEditingController();
    _bairroController = TextEditingController();
    _logradouroController = TextEditingController();
    _numeroController = TextEditingController();
    _complementoController = TextEditingController();
  }

  Future<String> toModel() async {
    if (!_formKey.currentState!.validate()) {
      return 'Por favor, preencha todos os campos obrigatórios';
    }

    if (_isAceptedTerms == false) {
      return 'Por favor, aceite os termos e condições de uso';
    }

    setState(() {
      _isCharging = true;
    });

    UserRegister userRegister = UserRegister(
        widget.user.nome,
        widget.user.email,
        widget.user.telefone,
        widget.user.senha,
        widget.user.tipo,
        Endereco(
            _cepController.text.split('-').join(),
            _estadoController.text,
            _paisController.text,
            _municipioController.text,
            _bairroController.text,
            _logradouroController.text,
            _numeroController.text,
            _complementoController.text));

    String response = await registrarUsuario(userRegister);

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
              onPressed: () =>
                  context.go("/principal-data", extra: widget.user),
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
                      _paisController, 'Pais', 'Por favor, insira o pais'),
                  const SizedBox(height: 25),
                  _buildTextField(_estadoController, 'Estado',
                      'Por favor, insira o estado'),
                  const SizedBox(height: 25),
                  _buildTextField(_municipioController, 'Município',
                      'Por favor, insira o Município'),
                  const SizedBox(height: 25),
                  _buildTextField(_bairroController, 'Bairro',
                      'Por favor, insira o bairro'),
                  const SizedBox(height: 25),
                  _buildTextField(_logradouroController, 'Logradouro',
                      'Por favor, insira o logradouro'),
                  const SizedBox(height: 25),
                  _buildTextField(_numeroController, 'Número',
                      'Por favor, insira o número'),
                  const SizedBox(height: 25),
                  _buildTextField(_complementoController, 'Complemento',
                      'Por favor, insira o complemento'),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<String>(
                    valueListenable: responseNotifier,
                    builder: (context, value, _) {
                      return Text(value,
                          style: const TextStyle(color: Colors.white));
                    },
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () => {
                            showTermsAndCondition(context).then((value) => {
                                  setState(() {
                                    _isAceptedTerms = value;
                                  })
                                })
                          },
                      child: const Text(
                          'Aperte aqui para ler os Termos e condições de uso',
                          style: TextStyle(color: Colors.white))),
                  const SizedBox(height: 25),
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
    Future<Cep> cepEncontrado;
    return SizedBox(
      width: 330,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) => {
          if (label == 'CEP')
            {
              if (value.length == 9)
                {
                  cepEncontrado = getCep(value.split('-').join()),
                  cepEncontrado.then((value) => {
                        _logradouroController.text = value.logradouro,
                        _bairroController.text = value.bairro,
                        _municipioController.text = value.localidade,
                        _estadoController.text = value.uf
                      })
                }
            }
        },
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
        validator: (value) {
          return validateNullField(value, label);
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
                  showRegisterSuccessfulModal(context);
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
