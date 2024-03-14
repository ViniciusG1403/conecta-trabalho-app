import 'package:conectatrabalho/pages/home/assets/menu-extensivel.dart';
import 'package:conectatrabalho/pages/home/models/busca-perfil-model.dart';
import 'package:conectatrabalho/pages/home/services/home-page-service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String urlFotoPerfil = '';
  late SearchController controller;
  late Image image;
  late List<UserModel> users = [];

  @override
  void initState() {
    controller = SearchController();
    getPerfilByUser().then((value) {
      setState(() {
        urlFotoPerfil = value.fotoPerfil;
        image = Image.network(urlFotoPerfil);
        users = value.usuarios;
      });
    });
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
                height: 80,
              ),
              Row(
                children: [
                  const SizedBox(width: 35),
                  urlFotoPerfil != ''
                      ? ClipRRect(
                          borderRadius:
                              BorderRadius.circular(screenSize.width * 0.3 / 2),
                          child: Image.network(
                            urlFotoPerfil,
                            width: screenSize.width * 0.115,
                            height: screenSize.width * 0.115,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircularProgressIndicator(),
                  const SizedBox(width: 230),
                  const CustomPopupMenu()
                ],
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: screenSize.width * 0.9,
                child: SearchBar(
                  controller: controller,
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Vagas próximas a você",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ...users
                  .map((user) => SizedBox(
                      width: screenSize.width * 0.9,
                      child: Card(
                          child: ListTile(
                        title: Text(
                          user.nome,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(user.id),
                      ))))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
