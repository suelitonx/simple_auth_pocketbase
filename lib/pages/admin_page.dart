import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/pocketbase_service.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<PocketbaseService>(context, listen: false).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Welcome to Admin Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
