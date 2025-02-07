import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medito/widgets/labeled_text_field/app_text_field.dart';

class LabeledTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String error;
  final String hint;
  final Function(bool, String?)? onFocusChange;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Color? labelColor;
  const LabeledTextField({
    super.key,
    this.controller,
    this.label = '',
    this.error = '',
    this.hint = '',
    this.onFocusChange,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.labelColor,
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
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 16,
              color: widget.labelColor ?? const Color(0xFF020202),
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 8),
          AppTextField(
            enabled: widget.enabled,
            focusNode: focusNode,
            hint: widget.hint,
            hasError: widget.error.isNotEmpty,
            controller: widget.controller,
            onSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            textInputAction: widget.textInputAction,
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
      ),
    );
  }
}
