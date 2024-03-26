import 'package:flutter/material.dart';

Widget customTextForm(
    {required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    String? Function(String?)? validate,
    Widget? preIcon,
    Widget? postIcon}) {
  return TextFormField(
    validator: validate,
    controller: controller,
    obscureText: isPassword,
    style: const TextStyle(fontSize: 18.0),
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: preIcon,
      suffixIcon: postIcon,
      border: const OutlineInputBorder(),
    ),
  );
}
