import 'package:conectatrabalho/pages/aplicacao/aplicacoes.dart';
import 'package:conectatrabalho/pages/empresas/candidato/empresa-completa.dart';
import 'package:conectatrabalho/pages/empresas/candidato/empresas-candidato.dart';
import 'package:conectatrabalho/pages/empresas/candidato/listagem-todas-vagas-empresa.dart';
import 'package:conectatrabalho/pages/home/home-page.dart';
import 'package:conectatrabalho/pages/initial/initial-page.dart';
import 'package:conectatrabalho/pages/login/login-page.dart';
import 'package:conectatrabalho/pages/register/models/retorno-cadastro-perfil.dart';
import 'package:conectatrabalho/pages/register/perfil-empresa-registro.dart';
import 'package:conectatrabalho/pages/register/localization-page.dart';
import 'package:conectatrabalho/pages/register/models/register-model.dart';
import 'package:conectatrabalho/pages/register/perfil-candidato-registro.dart';
import 'package:conectatrabalho/pages/register/preencher-documentos-registro.dart';
import 'package:conectatrabalho/pages/register/principal-data-page.dart';
import 'package:conectatrabalho/pages/register/register-page.dart';
import 'package:conectatrabalho/pages/vagas/detalhes-vaga-page.dart';
import 'package:conectatrabalho/pages/vagas/vagas-page.dart';
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
      pageBuilder: (context, state) => const MaterialPage(child: HomePage())),
  GoRoute(
      path: '/preencher-foto',
      pageBuilder: (context, state) {
        final retorno = state.extra as RetornoCadastroPerfil;
        return MaterialPage(
            child: PreencherDocumentosRegistro(retorno: retorno),
            fullscreenDialog: true);
      }),
  GoRoute(
      path: '/vagas',
      pageBuilder: (context, state) => const MaterialPage(child: VagasPage())),
  GoRoute(
      path: '/detalhes-vaga/:id',
      pageBuilder: (context, state) {
        String? id = state.pathParameters['id'];
        return MaterialPage(
            child: DetalhesVagaPage(id: id), fullscreenDialog: true);
      }),
  GoRoute(
      path: '/aplicacoes',
      pageBuilder: (context, state) =>
          const MaterialPage(child: AplicacoesPage())),
  GoRoute(
      path: '/empresas/candidato',
      pageBuilder: (context, state) =>
          const MaterialPage(child: EmpresasCandidatoPage())),
  GoRoute(
      path: '/empresa/:id/completo',
      pageBuilder: (context, state) {
        String? id = state.pathParameters['id'];
        return MaterialPage(
            child: EmpresaCompletaPage(id: id), fullscreenDialog: true);
      }),
  GoRoute(
      path: '/empresa/:id/vagas',
      pageBuilder: (context, state) {
        String? id = state.pathParameters['id'];
        return MaterialPage(
            child: ListagemTodasVagasEmpresaPage(idEmpresa: id),
            fullscreenDialog: true);
      }),
]);
