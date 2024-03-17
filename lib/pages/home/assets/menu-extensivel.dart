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
            value: "Vagas",
            child: TextButton.icon(
              icon: const Icon(Icons.groups_outlined, color: Colors.black),
              label: const Text(
                'Vagas',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => {routes.go("/vagas")},
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              icon:
                  const Icon(Icons.build_circle_outlined, color: Colors.black),
              label: const Text(
                'Configurações',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => {routes.go("/")},
            ),
          ),
          PopupMenuItem(
            value: "Sair",
            child: TextButton.icon(
              icon: const Icon(Icons.close, color: Colors.black),
              label: const Text(
                'Sair',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => {exitApp()},
            ),
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
