import 'package:flutter/material.dart';

class LabeledPasswordTextField extends StatelessWidget {
  final String label;
  final String value;
  final String hint;
  final bool obscured;
  const LabeledPasswordTextField({
    super.key,
    this.label = '',
    this.value = '',
    this.hint = '',
    this.obscured = true,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE2E2E2)),
      borderRadius: BorderRadius.circular(6),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF020202),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscured,
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
            suffix: SizedBox(
              height: 24,
              child: Text(
                obscured ? 'Show' : 'Hide',
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
