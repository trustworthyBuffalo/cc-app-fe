import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldNormal extends StatelessWidget {
  TextFieldNormal({
    super.key,
    required this.controller,
    required this.name,
    this.regexText,
  });

  final String name;
  final TextEditingController controller;
  String? regexText;

  String? checkValid(String? v) {
    if (v == null || v.isEmpty) {
      return "harus diisi";
    }

    var regex = RegExp(regexText!);

    if (!regex.hasMatch(v)) {
      return "$name, tidak valid";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text(name)),
      controller: controller,
      validator: (regexText == null) ? null : checkValid,
    );
  }
}
