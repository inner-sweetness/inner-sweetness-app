import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppDebouncedTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color fontColor;
  final Color color;
  final Color borderColor;
  final Color errorBorderColor;
  final Color highlightBorderColor;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final Widget? suffix;
  final double fontSize;
  final FontStyle? fontStyle;
  final bool obscureText;
  final bool autocorrect;

  final String? hint;
  final Color hintColor;

  final Function(String)? onChanged;
  final Function(String)? onDebounceChanged;
  final Function(String)? onSubmitted;

  final bool enabled;

  final bool autoFocus;
  final bool enableSuggestions;

  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  final double height;

  final bool readOnly;

  final VoidCallback? onTap;

  final List<TextInputFormatter>? inputFormatters;

  final double? radius;

  final TextAlign? textAlign;

  final Alignment? textAlignment;

  final TextAlignVertical? textAlignVertical;

  final int? maxLines;
  final int? minLines;
  final bool expands;

  final int debounceTime;
  final Color fillColor;

  const AppDebouncedTextField({
    super.key,
    this.height = 48,
    this.controller,
    this.focusNode,
    this.fontColor = Colors.black,
    this.hintColor = Colors.grey,
    this.color = Colors.white,
    this.borderColor = Colors.grey,
    this.errorBorderColor = Colors.grey,
    this.highlightBorderColor = Colors.blue,
    this.fontWeight,
    this.prefix,
    this.suffix,
    this.fontSize = 16,
    this.fontStyle,
    this.obscureText = false,
    this.autocorrect = true,
    this.hint,
    this.onChanged,
    this.onDebounceChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autoFocus = false,
    this.textInputAction,
    this.textInputType,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
    this.radius,
    this.textAlign,
    this.textAlignment,
    this.textAlignVertical,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.enableSuggestions = false,
    this.debounceTime = 500,
    this.fillColor = Colors.transparent,
  });

  @override
  State<AppDebouncedTextField> createState() => _AppDebouncedTextFieldState();
}

class _AppDebouncedTextFieldState extends State<AppDebouncedTextField> {
  Timer? _debounce;

  void _onChangedDebounce(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: widget.debounceTime), () {
      if (widget.onDebounceChanged != null) {
        widget.onDebounceChanged!(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius ?? 8),
      borderSide: BorderSide(
        color: widget.borderColor,
        width: 1,
      ),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius ?? 8),
      borderSide: BorderSide(
        color: widget.errorBorderColor,
        width: 1,
      ),
    );
    final inputHighlightBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius ?? 8),
      borderSide: BorderSide(
        color: widget.highlightBorderColor,
        width: 2,
      ),
    );
    return TextField(
      controller: widget.controller,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      obscureText: widget.obscureText,
      onChanged: (String value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        _onChangedDebounce(value);
      },
      onSubmitted: widget.onSubmitted,
      keyboardType: widget.textInputType,
      autofocus: widget.autoFocus,
      textInputAction: widget.textInputAction,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      expands: widget.expands,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign ?? TextAlign.start,
      textAlignVertical: widget.textAlignVertical,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight ?? FontWeight.w400,
        color: widget.fontColor,
        fontStyle: widget.fontStyle,
        letterSpacing: .5,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        filled: true,
        fillColor: widget.fillColor,
        hintStyle: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight ?? FontWeight.w400,
          color: widget.hintColor,
          fontStyle: widget.fontStyle,
          letterSpacing: .5,
        ),
        contentPadding: const EdgeInsets.all(12),
        border: inputBorder,
        errorBorder: errorBorder,
        disabledBorder: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputHighlightBorder,
        focusedErrorBorder: errorBorder,
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffix,
      ),
    );
  }
}
