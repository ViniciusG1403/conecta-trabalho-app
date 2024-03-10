import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SearchController controller;
  @override
  void initState() {
    controller = SearchController();
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  const SizedBox(width: 35),
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(screenSize.width * 0.3 / 2),
                    child: Image.network(
                      "https://img.freepik.com/fotos-gratis/uma-pintura-de-um-lago-de-montanha-com-uma-montanha-ao-fundo_188544-9126.jpg",
                      width: screenSize.width * 0.15,
                      height: screenSize.width * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 230),
                  IconButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ))
                ],
              ),
              const SizedBox(height: 35),
              SizedBox(
                  width: screenSize.width * 0.9,
                  child: SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
