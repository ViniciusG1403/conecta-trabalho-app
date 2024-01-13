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
    pageBuilder: (context, state) =>
        const MaterialPage(child: LoginPage(), fullscreenDialog: true),
  ),
  GoRoute(
    path: "/register",
    pageBuilder: (context, state) =>
        const MaterialPage(child: RegisterPage(), fullscreenDialog: true),
  ),
  GoRoute(
    path: "/localization-register",
    builder: (context, state) {
      final user = state.extra as User;
      return LocalizationPage(
        user: user,
      );
    },
  ),
  GoRoute(
      path: "/principal-data",
      builder: (context, state) {
        final user = state.extra as User;
        return PrincipalDataPage(user: user);
      }),
  GoRoute(
    path: "/initial-page",
    pageBuilder: (context, state) => const MaterialPage(child: InitialPage()),
  ),
]);
