import 'package:conectatrabalho/pages/initial/initial-page.dart';
import 'package:conectatrabalho/pages/login/login-page.dart';
import 'package:conectatrabalho/pages/register/localization-page.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
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
    path: "/localization-register/:name/:email/:password/:type",
    builder: (context, state) {
      final name = state.pathParameters["name"]!.toString();
      final email = state.pathParameters["email"]!.toString();
      final password = state.pathParameters["password"]!.toString();
      final type = state.pathParameters["type"]!.toString();
      User user = User(name, email, password, type);
      return LocalizationPage(
        user: user,
      );
    },
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
