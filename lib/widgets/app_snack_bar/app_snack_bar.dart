import 'package:flutter/material.dart';

class AppSnackBar {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showSuccessSnackBar(BuildContext context, {required String message}) =>
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showErrorSnackBar(BuildContext context, {required String message}) =>
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      showWarningSnackBar(BuildContext context, {required String message}) =>
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.yellow,
              content: Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
}
