import 'dart:math';

import 'package:conectatrabalho/pages/home/assets/menu-extensivel.dart';
import 'package:conectatrabalho/pages/home/home-page-candidato.dart';
import 'package:conectatrabalho/pages/home/services/home-page-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  List<String> recentSearches = [];
  String urlFotoPerfil = '';
  late SearchController controller;
  late Image image;

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  renderHomePageCandidato() {
    return HomePageCandidato();
  }

  @override
  void initState() {
    controller = SearchController();
    getPerfilByUser().then((value) {
      setState(() {
        urlFotoPerfil = value.fotoPerfil;
        image = Image.network(urlFotoPerfil);
      });
    });
    renderHomePageCandidato();
    initPrefs();
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
                  urlFotoPerfil != ''
                      ? Transform.rotate(
                          angle: pi / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              urlFotoPerfil,
                              width: screenSize.width * 0.160,
                              height: screenSize.width * 0.160,
                              fit: BoxFit.cover,
                            ),
                          ))
                      : const CircularProgressIndicator(),
                  const SizedBox(width: 210),
                  const CustomPopupMenu()
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
              renderHomePageCandidato(),
            ],
          ),
        ),
      ),
    );
  }
}
