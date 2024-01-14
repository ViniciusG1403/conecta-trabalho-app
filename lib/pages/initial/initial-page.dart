import 'package:conectatrabalho/pages/login/services/login-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  @override
  State<InitialPage> createState() => _InitialPageState();
}

Future<String> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');
  return username!;
}

class _InitialPageState extends State<InitialPage> {
  String name = "";

  @override
  void initState() {
    getUserName().then((value) => setState(() {
          name = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff220A55),
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => context.go("/"),
        ),
        actions: [Image.asset("assets/images/initial-page/logo-resumido.png")],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/initial-page/background-initial-page.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 160,
              ),
              SizedBox(
                width: screenSize.width * 0.8,
                child: Text(
                  "Bem vindo ao Conecta Trabalho, $name",
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenSize.width * 0.8,
                child: const Text(
                  "Para começar, complete seu perfil. Isso nos ajudará a conectar você com as melhores oportunidades de trabalho.",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenSize.width * 0.9,
                child: TextButton(
                    onPressed: () => {},
                    child: const Text(
                      "Preencha agora e dê o próximo passo em sua carreira!",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
