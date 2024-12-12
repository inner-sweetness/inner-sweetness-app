import 'package:flutter/material.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

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
          controller: TextEditingController(text: value),
          keyboardType: TextInputType.visiblePassword,
          hint: hint,
          obscured: obscured,
          suffix: const SizedBox(
            height: 24,
            width: 72,
            child: Center(
              child: Text(
                'Show',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
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
