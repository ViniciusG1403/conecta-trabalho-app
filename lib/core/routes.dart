import 'package:conectatrabalho/pages/initial/initial-page.dart';
import 'package:conectatrabalho/pages/login/login-page.dart';
import 'package:conectatrabalho/pages/register/contractor-profile-register.dart';
import 'package:conectatrabalho/pages/register/localization-page.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/principal-data-page.dart';
import 'package:conectatrabalho/pages/register/register-page.dart';
import 'package:conectatrabalho/pages/register/worker-profile-register.dart';
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
    pageBuilder: (context, state) {
      final user = state.extra as User;
      return MaterialPage(
          child: LocalizationPage(user: user), fullscreenDialog: true);
    },
  ),
  GoRoute(
    path: "/principal-data",
    pageBuilder: (context, state) {
      final user = state.extra as User;
      return MaterialPage(
          child: PrincipalDataPage(user: user), fullscreenDialog: true);
    },
  ),
  GoRoute(
    path: "/initial-page",
    pageBuilder: (context, state) => const MaterialPage(child: InitialPage()),
  ),
  GoRoute(
    path: "/worker-register",
    pageBuilder: (context, state) => const MaterialPage(
        child: WorkerProfileRegisterPage(), fullscreenDialog: true),
  ),
  GoRoute(
    path: "/contractor-register",
    pageBuilder: (context, state) => const MaterialPage(
        child: ContractorProfileRegisterPage(), fullscreenDialog: true),
  ),
]);
