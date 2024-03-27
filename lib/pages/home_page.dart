import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/pocketbase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<PocketbaseService>(context, listen: false).logout();
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
              if (Provider.of<PocketbaseService>(context).pb.authStore.model.data["name"] != null)
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(Provider.of<PocketbaseService>(context).pb.authStore.model.data["name"]),
                ),
              if (Provider.of<PocketbaseService>(context).pb.authStore.model.data["name"] != null)
                ListTile(
                  leading: const Icon(Icons.email_rounded),
                  title: const Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(Provider.of<PocketbaseService>(context).pb.authStore.model.data["email"]),
                ),
              if (Provider.of<PocketbaseService>(context).pb.authStore.model.data["name"] != null)
                ListTile(
                  leading: const Icon(Icons.account_box_rounded),
                  title: const Text('Username', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(Provider.of<PocketbaseService>(context).pb.authStore.model.data["username"]),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
