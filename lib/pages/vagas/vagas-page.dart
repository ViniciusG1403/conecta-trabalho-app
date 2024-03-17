import 'package:conectatrabalho/core/routes.dart';
import 'package:conectatrabalho/pages/home/assets/menu-extensivel.dart';
import 'package:conectatrabalho/pages/home/models/vagas-retorno-model.dart';
import 'package:conectatrabalho/pages/vagas/services/vagas-service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VagasPage extends StatefulWidget {
  const VagasPage({Key? key}) : super(key: key);

  @override
  State<VagasPage> createState() => _VagasPageState();
}

class _VagasPageState extends State<VagasPage> {
  late SharedPreferences prefs;
  List<String> recentSearches = [];
  late SearchController controller;
  bool pesquisarVagasProximas = true;

  ValueNotifier<Future<List<VagasRetornoModel>>> vagasNotifier =
      ValueNotifier(getVagasProximo());

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
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
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(width: 35),
                  IconButton(
                      onPressed: () => routes.go('/home'),
                      icon: const Icon(Icons.arrow_back, color: Colors.white)),
                  const SizedBox(width: 230),
                  const CustomPopupMenu()
                ],
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: screenSize.width * 0.9,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: screenSize.width * 0.9,
                child: SearchAnchor(
                    isFullScreen: false,
                    builder:
                        (BuildContext context, SearchController controller) {
                      return SearchBar(
                        controller: controller,
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 16.0)),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        hintText: "Pesquise por titulo de vagas",
                        onSubmitted: (value) => {
                          print(value),
                          recentSearches.add(value),
                          prefs.setStringList('recentSearches', recentSearches),
                        },
                        leading: const Icon(Icons.search),
                      );
                    },
                    suggestionsBuilder:
                        (BuildContext context, SearchController controller) {
                      return recentSearches.map((search) {
                        return ListTile(
                          title: Text(search),
                          onTap: () {
                            setState(() {
                              print(search);
                              controller.closeView(search);
                            });
                          },
                        );
                      }).toList();
                    }),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: screenSize.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Somente vagas próximas',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                        child: Switch(
                      value: pesquisarVagasProximas,
                      onChanged: (value) {
                        setState(() {
                          pesquisarVagasProximas = value;
                          if (value) {
                            vagasNotifier.value = getVagasProximo();
                          } else {
                            vagasNotifier.value = getTodasVagas(1);
                          }
                        });
                      },
                      activeColor: Colors.green,
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ValueListenableBuilder<Future<List<VagasRetornoModel>>>(
                valueListenable: vagasNotifier,
                builder: (context, future, _) {
                  return FutureBuilder<List<VagasRetornoModel>>(
                    future: future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<VagasRetornoModel>? vagasList = snapshot.data;
                        return Column(
                          children: vagasList!
                              .map((vaga) => SizedBox(
                                    width: screenSize.width * 0.9,
                                    child: Card(
                                      child: ListTile(
                                        title: Text(
                                          vaga.titulo, // ou qualquer campo que você deseje exibir
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        subtitle: Text('${vaga.descricao}...'),
                                        leading: const Icon(Icons.work),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
