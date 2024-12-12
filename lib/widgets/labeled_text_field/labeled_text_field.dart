import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String value;
  final String error;
  final String hint;
  const LabeledTextField({
    super.key,
    this.label = '',
    this.value = '',
    this.error = '',
    this.hint = '',
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: error.isNotEmpty ? const Color(0xFFFF4E64) : const Color(0xFFE2E2E2)),
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
          ),
        ),
        if (error.isNotEmpty)
          ...[
            const SizedBox(height: 8),
            Text(
              error,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFFFF4E64),
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.start,
            ),
          ],
      ],
    );
  }
}
