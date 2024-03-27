import 'package:flutter/material.dart';
import 'package:pbauth/services/pocketbase_service.dart';
import 'package:pbauth/widgets/button_login.dart';
import 'package:pbauth/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  bool register = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_rounded, size: 100, color: Colors.deepPurple),
              Text(register ? 'Register Page' : 'Login Page', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              if (register) const SizedBox(height: 20),
              if (register)
                CustomTextField(
                  controller: nameController,
                  hintText: 'Name',
                ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                isPass: true,
              ),
              const SizedBox(height: 20),
              ButtonLogin(
                text: register ? 'Register' : 'Login',
                onTap: () => register ? registerUser() : loginUser(),
                isLoading: isLoading,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(register ? 'Already have an account?' : 'Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        register = !register;
                      });
                    },
                    child: Text(register ? 'Login' : 'Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    bool result = await Provider.of<PocketbaseService>(context, listen: false).login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (result == false) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
          ),
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void registerUser() async {
    setState(() {
      isLoading = true;
    });

    bool result = await Provider.of<PocketbaseService>(context, listen: false).register(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ? 'Register success, please login.' : 'Register failed.'),
        ),
      );
    }

    setState(() {
      isLoading = false;
      register = !result;
    });
  }
}
