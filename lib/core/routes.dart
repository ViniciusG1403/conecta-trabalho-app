import 'package:conectatrabalho/pages/login-page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: "/",
    pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
  ),
]);
