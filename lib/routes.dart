import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'pages/admin_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'services/pocketbase_service.dart';

List<GoRoute> getRoutes(BuildContext context) {
  FutureOr<String?> adminRedirect(BuildContext context, GoRouterState state) {
    return Provider.of<PocketbaseService>(context, listen: false).pb.authStore.model.data["role"] == 1 ? '/admin' : null;
  }

  FutureOr<String?> protectRouter(BuildContext context, GoRouterState state) {
    return Provider.of<PocketbaseService>(context, listen: false).pb.authStore.model.data["role"] == 0 ? '/' : null;
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
  ];
}
