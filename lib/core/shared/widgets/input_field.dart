import "package:flutter/material.dart";

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscure;
  final int? lines;
  final String? Function(String? value)? validator;

  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    this.isObscure = false,
    this.lines = 1,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      obscuringCharacter: "o",
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hint,
        counterText: "",
      ),
      validator: validator,
    );
  }
}
