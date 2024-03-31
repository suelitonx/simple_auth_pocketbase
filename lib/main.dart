import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import 'services/pocketbase_service.dart';

void main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  FutureOr<String?> authProtectRouter(BuildContext context, GoRouterState state, WidgetRef ref) {
    final duplicate = ref.watch(pbServiceProvider).duplicate;
    final isPageLogin = state.path == '/login';
    final logado = ref.watch(pbServiceProvider).pb.authStore.isValid;

    if (!logado && !isPageLogin && !duplicate) {
      if (kDebugMode) {
        print('redirect to login && duplicate = true');
      }
      ref.read(pbServiceProvider.notifier).duplicate = true;
      return '/login';
    }

    if (isPageLogin && logado && !duplicate) {
      if (kDebugMode) {
        print('redirect to home && duplicate = true');
      }
      ref.read(pbServiceProvider.notifier).duplicate = true;
      return '/';
    }

    if (duplicate) {
      if (kDebugMode) {
        print('duplicate = false');
      }
      ref.read(pbServiceProvider.notifier).duplicate = false;
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pocketbase Auth',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        redirect: (context, state) => authProtectRouter(context, state, ref),
        routes: getRoutes(context, ref),
      ),
    );
  }
}
