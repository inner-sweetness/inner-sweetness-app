import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final bool obscured;
  final bool hasError;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final BorderRadius? borderRadius;
  final FocusNode? focusNode;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  const AppTextField({
    super.key,
    this.controller,
    this.hint = '',
    this.obscured = false,
    this.hasError = false,
    this.suffix,
    this.keyboardType,
    this.borderRadius,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: hasError ? const Color(0xFFFF4E64) : const Color(0xFFE2E2E2)),
      borderRadius: borderRadius ?? BorderRadius.circular(6),
    );
    return TextField(
      enabled: enabled,
      readOnly: readOnly,
      focusNode: focusNode,
      controller: controller,
      textAlign: TextAlign.start,
      keyboardType: keyboardType,
      obscureText: obscured,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onTap: onTap,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6A6C6A),
        ),
        contentPadding: const EdgeInsets.all(12),
        border: inputBorder,
        errorBorder: inputBorder,
        disabledBorder: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        suffixIcon: suffix,
      ),
    );
  }
}
