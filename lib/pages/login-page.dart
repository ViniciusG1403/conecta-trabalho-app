import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _senhaController;
  String _feedbackMessage = "";
  bool _isPasswordVisible = false;
  bool _isCharging = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _senhaController = TextEditingController(text: "");
  }

  // void realizarLogin() async {
  //   String email = _emailController.text;
  //   String senha = _senhaController.text;

  //   setState(() {
  //     _isCharging = true;
  //   });

  //   String response = await RealizarLogin(email, senha);
  //   setState(() {
  //     _feedbackMessage = response;
  //     _isCharging = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 330,
                  height: 50,
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.mail_outline,
                        color: Colors.white,
                      ),
                      labelText: 'Email',
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
                const Text(''),
                SizedBox(
                    width: 330,
                    height: 50,
                    child: TextField(
                      controller: _senhaController,
                      style: const TextStyle(color: Colors.white),
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.password_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Senha',
                        labelStyle: const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          borderSide: BorderSide(color: Colors.white),
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
                    )),
                const Text(""),
                SizedBox(
                  child: _isCharging
                      ? const CircularProgressIndicator(
                          color: Colors.black,
                        )
                      : OutlinedButton(
                          onPressed: () => {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                          child: const Text("Entrar",
                              style: TextStyle(color: Colors.black)),
                        ),
                ),
                Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                          'assets/images/login-page/google-login.png'),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                          'assets/images/login-page/linkedin-login.png'),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                          'assets/images/login-page/facebook-login.png'),
                    ),
                  ],
                ),
                Text(_feedbackMessage),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
