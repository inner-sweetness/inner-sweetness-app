import 'package:flutter/material.dart';

class AppLoadingOverlay extends StatelessWidget {
  const AppLoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 32,
        width: 32,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 1,
          ),
        ),
      ),
    );
  }
}

class DialogLoading {
  bool _dialogOpen = false;
  String message;

  DialogLoading({this.message = ''});

  Future<void> show(BuildContext context, { bool dismissible = true }) async {
    if (!_dialogOpen) {
      _dialogOpen = true;
      await showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (_) => const AppLoadingOverlay(),
      );
      _dialogOpen = false;
    }
  }

  Future<void> hide(BuildContext context) async {
    if (_dialogOpen) {
      Navigator.pop(context);
      _dialogOpen = false;
    }
  }
}
