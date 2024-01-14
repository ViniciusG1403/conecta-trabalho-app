import 'package:conectatrabalho/pages/login/login-page.dart';
import 'package:conectatrabalho/pages/register/contractor-profile-register.dart';
import 'package:conectatrabalho/pages/register/worker-profile-register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final initialPageRoutes = GoRouter(routes: [
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
