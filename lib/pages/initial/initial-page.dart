import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/initial/models/user-model.dart';
import 'package:conectatrabalho/pages/initial/services/initial-page-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  @override
  State<InitialPage> createState() => _InitialPageState();
}

String username = "";

String messageForUsers = "";

int userType = 0;

Future<void> getUserFromLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? idUser = prefs.getString('uidUsuario');
  bool hasProfile = await userWithProfile(idUser);
  if (!hasProfile) {
    User user = await getUser(idUser);

    username = user.nome.split(" ")[0];

    userType = user.tipo;

    if (user.tipo == 0) {
      messageForUsers =
          "Para começar, complete seu perfil. Isso nos ajudará a conectar você com as melhores oportunidades de trabalho.";
    } else {
      messageForUsers =
          "Para começar, complete seu perfil. Isso nos ajudará a conectar você com os melhores profissionais da sua área.";
    }
    return;
  }

  routes.go("/home");
}

class _InitialPageState extends State<InitialPage> {
  String name = "";

  @override
  void initState() {
    getUserFromLogin().then((value) => setState(() {
          name = username;
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
                height: 200,
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
                child: Text(
                  messageForUsers,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenSize.width * 0.9,
                child: TextButton(
                    onPressed: () => {
                          if (userType == 0)
                            context.go("/registro-candidato")
                          else
                            context.go("/registro-empresa")
                        },
                    child: const Text(
                      "Preencha agora e dê o próximo passo!",
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
