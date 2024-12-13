import 'package:flutter/material.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

class LabeledPasswordTextField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String hint;
  final String error;
  final bool obscured;
  final VoidCallback? onSuffixTap;
  final Function(bool, String?)? onFocusChange;
  final Function(String)? onSubmitted;
  const LabeledPasswordTextField({
    super.key,
    this.label = '',
    this.controller,
    this.hint = '',
    this.error = '',
    this.obscured = true,
    this.onSuffixTap,
    this.onFocusChange,
    this.onSubmitted,
  });

  @override
  State<LabeledPasswordTextField> createState() => _LabeledPasswordTextFieldState();
}

class _LabeledPasswordTextFieldState extends State<LabeledPasswordTextField> {
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
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          hint: widget.hint,
          obscured: widget.obscured,
          onSubmitted: widget.onSubmitted,
          hasError: widget.error.isNotEmpty,
          suffix: GestureDetector(
            onTap: widget.onSuffixTap,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              height: 24,
              width: 72,
              child: Center(
                child: Text(
                  widget.obscured ? 'Show' : 'Hide',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.black,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
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
