import 'package:flutter/material.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

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
        AppTextField(
          hint: hint,
          hasError: error.isNotEmpty,
          controller: TextEditingController(text: value)
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
