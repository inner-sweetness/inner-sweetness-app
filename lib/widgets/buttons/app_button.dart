import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double fontSize;
  final Color color;
  final Color? borderColor;
  final Color hoveredColor;
  final Color pressedColor;
  final Color? fontColor;
  final Color? disabledColor;
  final Color? disabledFontColor;
  final double radius;
  final EdgeInsets padding;

  const AppButton({
    super.key,
    this.text = '',
    this.onTap,
    this.fontSize = 16,
    this.color = Colors.black,
    this.borderColor,
    this.hoveredColor = Colors.black45,
    this.pressedColor = Colors.black87,
    this.fontColor = Colors.white,
    this.disabledColor = Colors.grey,
    this.disabledFontColor = Colors.white,
    this.radius = 8,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: onTap != null ? Colors.white : Colors.grey,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return disabledColor ?? Colors.grey;
            }
            if (states.contains(WidgetState.hovered)) {
              return hoveredColor;
            }
            if (states.contains(WidgetState.pressed)) {
              return pressedColor;
            }
            return color;
          },
        ),
      ),
      child: Padding(
        padding: padding,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            color: onTap != null
                ? (fontColor ?? Colors.white)
                : (disabledFontColor ?? Colors.black12),
          ),
          maxLines: null,
        ),
      ),
    );
  }
}
