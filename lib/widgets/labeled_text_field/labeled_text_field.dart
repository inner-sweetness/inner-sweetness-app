import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String value;
  final String hint;
  const LabeledTextField({super.key, this.label = '', this.value = '', this.hint = ''});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(12));
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
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
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
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
      ],
    );
  }
}
