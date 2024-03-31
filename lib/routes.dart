import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'pages/admin_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/other_page.dart';
import 'services/pocketbase_service.dart';

List<GoRoute> getRoutes(BuildContext context, WidgetRef ref) {
  FutureOr<String?> adminRedirect(BuildContext context, GoRouterState state) {
    return ref.read(pbServiceProvider).pb.authStore.model.data["tipo"] == 3 ? '/admin' : null;
  }

  FutureOr<String?> protectRouter(BuildContext context, GoRouterState state) {
    return ref.read(pbServiceProvider).pb.authStore.model.data["tipo"] == 0 ? '/' : null;
  }

  return [
    GoRoute(
      redirect: adminRedirect,
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      redirect: protectRouter,
      path: '/admin',
      builder: (context, state) => const AdminPage(),
    ),
    GoRoute(
      //redirect: protectRouter,
      path: '/other',
      pageBuilder: (context, state) {
        return const MaterialPage(child: OtherPage());
      },
    ),
  ];
}
