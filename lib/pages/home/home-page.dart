import 'package:conectatrabalho/pages/home/home-page-candidato.dart';
import 'package:conectatrabalho/pages/home/home-page-empresa.dart';
import 'package:conectatrabalho/pages/initial/services/initial-page-service.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-alerta.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/exibir-mensagem-sucesso.dart';
import 'package:conectatrabalho/shared/exibir-mensagens/mostrar-mensagem-erro.dart';
import 'package:conectatrabalho/shared/menu/menu-extensivel.dart';
import 'package:conectatrabalho/shared/tratamento-documentos-imagens/image-picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  String urlFotoPerfil = '';
  bool carregandoFotoPerfil = true;
  late SearchController controller;
  late MenuController _menuController;
  late Image image;
  late String idUsuario;
  late int tipoUsuario;

  void initPrefs() async {
    tipoUsuario = 0;
    prefs = await SharedPreferences.getInstance();
    tipoUsuario = prefs.getInt("tipoUsuario")!;
    setState(() {
      idUsuario = prefs.getString("uidUsuario")!;
    });
  }

  renderPage() {
    if (tipoUsuario == 0) {
      return HomePageCandidato();
    }
    return HomePageEmpresa();
  }

  carregarPerfilUsuario() async {
    try {
      prefs = await SharedPreferences.getInstance();
      DateTime now = DateTime.now();
      int timefoto = 0;
       try {
        timefoto = prefs.getInt("timefoto")!;
       } catch (e) {
        timefoto = 0;
       }
      if (now.millisecondsSinceEpoch - timefoto > 59000) {
        getProfile().then((value) {
          setState(() {
            urlFotoPerfil = value.fotoPerfil;
            image = Image.network(urlFotoPerfil);
            carregandoFotoPerfil = false;
          });
        });
        return;
      }
      setState(() {
        urlFotoPerfil = prefs.getString("fotoPerfil")!;
        image = Image.network(urlFotoPerfil);
        carregandoFotoPerfil = false;
      });
    } catch (e) {
      exibirMensagemErro(context, "Erro ao carregar foto de perfil");
    }
  }

  @override
  void initState() {
    initPrefs();
    controller = SearchController();
    _menuController = MenuController();
    carregarPerfilUsuario();
    renderPage();
    super.initState();
  }

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
                'assets/images/initial-page/background-initial-page.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Row(
                children: [
                  const SizedBox(width: 35),
                  !carregandoFotoPerfil
                      ? GestureDetector(
                          onTap: () async => {
                                setState(() {
                                  this.carregandoFotoPerfil = true;
                                }),
                                await imagePicker(idUsuario, context),
                                exibirMensagemSucesso(context,
                                    "A imagem pode demorar até 15 segundos para ser atualizada"),
                                Future.delayed(Duration(seconds: 5), () {
                                  setState(() {
                                    carregarPerfilUsuario();
                                    this.carregandoFotoPerfil = false;
                                  });
                                }),
                                exibirMensagemAlerta(context,
                                    "Caso a imagem não atualize, saia e entre novamente na aplicação")
                              },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(
                                    255, 255, 255, 255), // Cor da borda
                                width: 3, // Largura da borda
                              ),
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                urlFotoPerfil,
                                width: screenSize.width * 0.160,
                                height: screenSize.width * 0.160,
                                fit: BoxFit.scaleDown,
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                          ))
                      : const CircularProgressIndicator(),
                  const SizedBox(width: 210),
                  tipoUsuario == 0 ?  CustomPopupMenuCandidato() : CustomPopupMenuEmpresa(),
                ],
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: screenSize.width * 0.9,
              ),
              const SizedBox(height: 10),
              const SizedBox(
                height: 15,
              ),
              renderPage(),
            ],
          ),
        ),
      ),
    );
  }
}
