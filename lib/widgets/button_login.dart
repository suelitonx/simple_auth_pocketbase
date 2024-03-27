import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool isLoading;

  const ButtonLogin({super.key, this.onTap, this.text = 'Sign In', this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)) : Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }
}
