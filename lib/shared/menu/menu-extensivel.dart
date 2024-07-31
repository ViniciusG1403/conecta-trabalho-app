import 'package:conectatrabalho/core/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(Icons.groups_outlined),
                Text(" "),
                Text("Vagas", style: TextStyle(color: Colors.black)),
              ],
            ),
            onTap: () => routes.go("/vagas"),
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(Icons.store),
                Text(" "),
                Text("Empresas", style: TextStyle(color: Colors.black)),
              ],
            ),
            onTap: () => routes.go("/empresas/candidato"),
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(Icons.person),
                Text(" "),
                Text("Aplicações", style: TextStyle(color: Colors.black)),
              ],
            ),
            onTap: () => routes.go("/aplicacoes"),
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(Icons.exit_to_app),
                Text(" "),
                Text("Sair", style: TextStyle(color: Colors.black)),
              ],
            ),
            onTap: () => exitApp(),
          ),
        ];
      },
      onSelected: (value) {
        if (value == "Sair") {
          exitApp();
        }

        if (value == "Vagas") {
          routes.go("/vagas");
        }

        if (value == "Aplicações") {
          routes.go("/aplicacoes");
        }
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
    );
  }
}

void exitApp() {
  SharedPreferences.getInstance().then((prefs) {
    prefs.clear();
  });
  routes.go('/');
}
