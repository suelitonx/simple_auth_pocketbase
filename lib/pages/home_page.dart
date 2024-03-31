import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../services/pocketbase_service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(pbServiceProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Welcome to Home Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              if (ref.watch(pbServiceProvider).pb.authStore.model.data["name"] != null)
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(ref.watch(pbServiceProvider).pb.authStore.model.data["name"]),
                ),
              if (ref.watch(pbServiceProvider).pb.authStore.model.data["name"] != null)
                ListTile(
                  leading: const Icon(Icons.email_rounded),
                  title: const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(ref.watch(pbServiceProvider).pb.authStore.model.data["email"]),
                ),
              if (ref.watch(pbServiceProvider).pb.authStore.model.data["name"] != null)
                ListTile(
                  leading: const Icon(Icons.account_box_rounded),
                  title: const Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(ref.watch(pbServiceProvider).pb.authStore.model.data["username"]),
                ),
              ListTile(
                leading: const Icon(Icons.navigate_next_rounded),
                title: const Text("GO OTHER PAGE"),
                onTap: () {
                  context.push('/other');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
