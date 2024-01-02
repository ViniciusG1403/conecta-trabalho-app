import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                'assets/images/register-page/register-select-type-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Card(
                          elevation: 4,
                          child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                  'assets/images/register-page/contractor-icon.png'))),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                          elevation: 4,
                          child: Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(
                                  'assets/images/register-page/employee-icon.png'))),
                    ),
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
