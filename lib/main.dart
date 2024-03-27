import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pbauth/pages/admin_page.dart';
import 'package:provider/provider.dart';
import 'services/pocketbase_service.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FutureOr<String?> adminRedirect(BuildContext context, GoRouterState state) {
    return Provider.of<PocketbaseService>(context, listen: false).pb.authStore.model.data["role"] == 1 ? '/admin' : null;
  }

  FutureOr<String?> protectRouter(BuildContext context, GoRouterState state) {
    return Provider.of<PocketbaseService>(context, listen: false).pb.authStore.model.data["role"] == 0 ? '/' : null;
  }

  FutureOr<String?> authProtectRouter(BuildContext context, GoRouterState state) {
    return (Provider.of<PocketbaseService>(context, listen: false).pb.authStore.isValid == false) ? '/login' : null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PocketbaseService()),
      ],
      child: Consumer<PocketbaseService>(
        builder: (context, pbService, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Pocketbase Auth',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: GoRouter(
              redirect: authProtectRouter,
              routes: [
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
              ],
            ),
          );
        },
      ),
    );
  }
}
