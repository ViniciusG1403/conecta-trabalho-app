import 'package:conectatrabalho/pages/initial/initial-page.dart';
import 'package:conectatrabalho/pages/login-page.dart';
import 'package:conectatrabalho/pages/register/localization-page.dart';
import 'package:conectatrabalho/pages/register/principal-data-page.dart';
import 'package:conectatrabalho/pages/register/register-page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: "/",
    pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
  ),
  GoRoute(
    path: "/register",
    pageBuilder: (context, state) => const MaterialPage(child: RegisterPage()),
  ),
  GoRoute(
    path: "/localization-register",
    pageBuilder: (context, state) =>
        const MaterialPage(child: LocalizationPage()),
  ),
  GoRoute(
      path: "/principal-data/:type",
      builder: (context, state) {
        final type = state.pathParameters["type"]!.toString();
        return PrincipalDataPage(type: type);
      }),
  GoRoute(
    path: "/initial-page",
    pageBuilder: (context, state) => const MaterialPage(child: InitialPage()),
  ),
]);
