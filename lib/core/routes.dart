import 'package:conectatrabalho/pages/home/home-page.dart';
import 'package:conectatrabalho/pages/initial/initial-page.dart';
import 'package:conectatrabalho/pages/login/login-page.dart';
import 'package:conectatrabalho/pages/register/models/retorno-cadastro-perfil.dart';
import 'package:conectatrabalho/pages/register/perfil-empresa-registro.dart';
import 'package:conectatrabalho/pages/register/localization-page.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/perfil-candidato-registro.dart';
import 'package:conectatrabalho/pages/register/preencher-foto-perfil.dart';
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
    path: "/registro-candidato",
    pageBuilder: (context, state) => const MaterialPage(
        child: PerfilCandidatoRegistro(), fullscreenDialog: true),
  ),
  GoRoute(
    path: "/registro-empresa",
    pageBuilder: (context, state) => const MaterialPage(
        child: PerfilEmpresaRegistro(), fullscreenDialog: true),
  ),
  GoRoute(
      path: '/home',
      pageBuilder: (context, state) => MaterialPage(child: HomePage())),
  GoRoute(
      path: '/preencher-foto',
      pageBuilder: (context, state) {
        final retorno = state.extra as RetornoCadastroPerfil;
        return MaterialPage(
            child: PreencherFotoPerfil(retorno: retorno),
            fullscreenDialog: true);
      })
]);
