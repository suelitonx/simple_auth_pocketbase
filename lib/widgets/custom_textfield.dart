import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool isPass;

  const CustomTextField({super.key, this.controller, this.hintText, this.isPass = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          obscureText: isPass,
          controller: controller,
          decoration: InputDecoration(hintText: hintText, border: InputBorder.none),
        ),
      ),
    );
  }
}
