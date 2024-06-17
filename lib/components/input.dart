import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.hintText,
      this.suffix,
      this.controller,
      this.errorMaxLines,
      this.type,
      this.hintStyle,
      this.obscureText,
      this.validator,
      this.inputFormatters});
  final String hintText;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType? type;
  final bool? obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final int? errorMaxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        validator: validator,
        obscuringCharacter: '●',
        inputFormatters: inputFormatters,
        obscureText: obscureText ?? false,
        keyboardType: type ?? TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          errorMaxLines: errorMaxLines ?? 1,
          suffixIcon: suffix,
          hintStyle: hintStyle ?? const TextStyle(color: Color(0xFFD1D1D1)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFD1D1D1),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFD1D1D1),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFD1D1D1),
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          hintText: hintText,
        ),
      ),
    );
  }
}
