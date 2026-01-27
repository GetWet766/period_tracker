import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    this.obscureText = false,
    this.validator,
    this.controller,
    this.keyboardType,
    this.labelText,
    this.hintText,
    this.errorText,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    super.key,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final InputBorder? border;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        border:
            border ??
            OutlineInputBorder(
              borderRadius: .circular(16),
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorMaxLines: 3,
      ),
    );
  }
}
