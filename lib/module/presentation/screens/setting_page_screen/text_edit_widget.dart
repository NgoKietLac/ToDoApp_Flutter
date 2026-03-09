import 'package:flutter/material.dart';

class TextEditWidget extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscure;

  const TextEditWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
