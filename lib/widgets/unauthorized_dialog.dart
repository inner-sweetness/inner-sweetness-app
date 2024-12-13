import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/di/app_config.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/login/bloc/login_bloc.dart';

class UnauthorizedDialog extends StatefulWidget {
  const UnauthorizedDialog({super.key});

  @override
  State<UnauthorizedDialog> createState() => _UnauthorizedDialogState();
}

class _UnauthorizedDialogState extends State<UnauthorizedDialog> {
  final loginBloc = getIt<LoginBloc>();

  @override
  void dispose() {
    super.dispose();
    loginBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          // logout logic
        }
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 34),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          (const Color(0xFFBFE2F4)).withOpacity(.2),
                          (const Color(0xFF1A7CB6)).withOpacity(.2),
                        ],
                        stops: const [
                          0,
                          1,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Unathorized',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showUnauthorizedDialog() {
  final context = getIt<AppConfig>().context;
  if (context == null) return;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const UnauthorizedDialog(),
  );
  getIt<AppConfig>().context = null;
}
