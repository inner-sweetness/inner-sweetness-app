import 'package:flutter/material.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

class LabeledTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String error;
  final String hint;
  final Function(bool, String?)? onFocusChange;
  final Function(String)? onSubmitted;
  const LabeledTextField({
    super.key,
    this.controller,
    this.label = '',
    this.error = '',
    this.hint = '',
    this.onFocusChange,
    this.onSubmitted,
  });

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  final focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(() {
      widget.onFocusChange?.call(focusNode.hasFocus, widget.controller?.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF020202),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        AppTextField(
          focusNode: focusNode,
          hint: widget.hint,
          hasError: widget.error.isNotEmpty,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
        ),
        if (widget.error.isNotEmpty)
          ...[
            const SizedBox(height: 8),
            Text(
              widget.error,
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
