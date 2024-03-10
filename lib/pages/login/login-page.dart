import 'package:conectatrabalho/pages/login/modals/active-user-modal.dart';
import 'package:conectatrabalho/pages/register/services/validate-fields-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'services/login-service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  final _formKey = GlobalKey<FormState>();
  String _feedbackMessage = "";
  bool _isPasswordVisible = false;
  bool _isCharging = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _senhaController = TextEditingController(text: "");
  }

  void realizarLogin() async {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (this._formKey.currentState!.validate() == false) {
      return;
    }

    setState(() {
      _isCharging = true;
    });

    String response = await RealizarLogin(email, senha);
    if (response == "Usuario inativo") {
      showActivationModal(context, email, senha);
    }
    setState(() {
      _feedbackMessage = response == "Usuario inativo" ? "" : response;
      _isCharging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/login-page/login-page-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Form(
                      key: _formKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            width: 330,
                            child: TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              validator: (value) {
                                if (value == null || value == "") {
                                  return validateNullField(value, "email");
                                }
                                return validateEmailFormatRegex(value);
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.white,
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const Text(''),
                          SizedBox(
                            width: 330,
                            child: TextFormField(
                              controller: _senhaController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: !_isPasswordVisible,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return validateNullField(value, "Senha");
                                }
                              },
                              decoration: InputDecoration(
                                icon: const Icon(
                                  Icons.password_outlined,
                                  color: Colors.white,
                                ),
                                labelText: 'Senha',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(14)),
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const Text(""),
                  SizedBox(
                    child: _isCharging
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : OutlinedButton(
                            onPressed: () => realizarLogin(),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                            ),
                            child: const Text("Entrar",
                                style: TextStyle(color: Colors.black)),
                          ),
                  ),
                  const Text(""),
                  Text(_feedbackMessage,
                      style: const TextStyle(color: Colors.white)),
                  const Text(""),
                  const Text(""),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ainda não possui uma conta?",
                          style: TextStyle(color: Colors.white)),
                      TextButton(
                          onPressed: () => context.go("/register"),
                          child: const Text(
                            "Cadastre-se",
                            style: TextStyle(
                                color: Color.fromARGB(255, 160, 159, 159)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
