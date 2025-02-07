import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/services/notifications/firebase_notifications_service.dart';
import 'package:medito/views/bottom_navigation/bottom_navigation_bar_view.dart';
import 'package:medito/views/downloads/downloads_view.dart';
import 'package:medito/views/onboarding/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/root/root_page_view.dart';
import 'package:medito/views/splash_view/bloc/validate_login_bloc/validate_login_bloc.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  void _initializeUser(bool isLoggedIn) async {
    try {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => const RootPageView(
              firstChild: BottomNavigationBarView(),
            ),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => const OnboardingView(),
          ),
        );
      }
    } catch (e) {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const DownloadsView(),
      ));
      return;
    }
  }

  void _initializeFirebaseMessaging() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final firebaseMessaging = ref.read(firebaseMessagingProvider);
      firebaseMessaging.initialize(context, ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ValidateLoginBloc>(
      create: (_) => getIt<ValidateLoginBloc>()..add(const ValidateLogin()),
      child: BlocListener<ValidateLoginBloc, ValidateLoginState>(
        listener: (context, ValidateLoginState state) {
          if (state is ValidateLoginSuccessState) {
            _initializeUser(state.valid);
            _initializeFirebaseMessaging();
          }
        },
        child: SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/splash_screen_background.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
