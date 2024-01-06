import 'package:conectatrabalho/pages/register/modals/register-succesfull-modal.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/services/register-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  String _feedbackMessage = "";
  bool _isPasswordVisible = false;
  bool _isCharging = false;
  ValueNotifier<String> responseNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _cepController = TextEditingController(text: "");
    _streetController = TextEditingController(text: "");
    _neighborhoodController = TextEditingController(text: "");
    _numberController = TextEditingController(text: "");
    _complementController = TextEditingController(text: "");
    _cityController = TextEditingController(text: "");
    _stateController = TextEditingController(text: "");
  }

  Future<String> toModel() async {
    setState(() {
      _isCharging = true;
    });
    String cep = _cepController.text;
    String street = _streetController.text;
    String neighborhood = _neighborhoodController.text;
    String number = _numberController.text;
    String complement = _complementController.text;
    String city = _cityController.text;
    String state = _stateController.text;

    UserRegister userRegister = UserRegister(
        widget.user.name,
        widget.user.email,
        widget.user.password,
        widget.user.type,
        Localization(
            cep, street, number, complement, neighborhood, city, state));
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
          backgroundColor: const Color(0xff413EFF),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => context.go("/register"),
          )),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/register-page/principal-data-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 330,
                  height: 50,
                  child: TextField(
                    controller: _cepController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'CEP',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 330,
                  height: 50,
                  child: TextField(
                    controller: _streetController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Rua',
                      labelStyle: TextStyle(color: Colors.white),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 330,
                    height: 50,
                    child: TextField(
                      controller: _neighborhoodController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Bairro',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 330,
                    height: 50,
                    child: TextField(
                      controller: _numberController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Número',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 330,
                    height: 50,
                    child: TextField(
                      controller: _complementController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Complemento',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 330,
                    height: 50,
                    child: TextField(
                      controller: _cityController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Cidade',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 330,
                    height: 50,
                    child: TextField(
                      controller: _stateController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Estado',
                        labelStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                ValueListenableBuilder<String>(
                  valueListenable: responseNotifier,
                  builder: (context, value, _) {
                    return Text(value,
                        style: const TextStyle(color: Colors.white));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: _isCharging
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : OutlinedButton(
                          onPressed: () async {
                            String response = await toModel();
                            if (response == "Cadastro realizado com sucesso") {
                              showRegisterSuccesfullModal(context);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                          child: const Text("Salvar",
                              style: TextStyle(color: Colors.black)),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
