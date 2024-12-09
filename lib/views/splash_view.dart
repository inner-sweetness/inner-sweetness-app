import 'package:lottie/lottie.dart';
import 'package:medito/repositories/auth/auth_repository.dart';
import 'package:medito/services/notifications/firebase_notifications_service.dart';
import 'package:medito/utils/stats_manager.dart';
import 'package:medito/views/bottom_navigation/bottom_navigation_bar_view.dart';
import 'package:medito/views/downloads/downloads_view.dart';
import 'package:medito/views/onboarding/onboarding_view.dart';
import 'package:medito/views/root/root_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/utils/fade_page_route.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeUser() async {
    try {
      await Navigator.of(context).pushReplacement(
        FadePageRoute(
          builder: (context) => const OnboardingView(),
        ),
      );
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Lottie.asset(
          'assets/animations/Splash_Animation.json',
          controller: _controller,
          fit: BoxFit.fill,
          onLoaded: (composition) {
            _controller
              ..duration = const Duration(milliseconds: 1000)
              ..forward().whenComplete(() {
                _initializeUser();
                _initializeFirebaseMessaging();
              });
          },
        ),
      ),
    );
  }
}
