import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/utils/stats_manager.dart';
import 'package:medito/views/login/login_view.dart';
import 'package:medito/widgets/buttons/app_button.dart';

class SubscribeView extends ConsumerStatefulWidget {
  const SubscribeView({super.key});

  @override
  ConsumerState<SubscribeView> createState() => _SubscribeViewState();
}

class _SubscribeViewState extends ConsumerState<SubscribeView> {

  Future<void> initializeUser() async {
    await StatsManager().sync();
    await Navigator.of(context).pushReplacement(
      FadePageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Material(
                      color: const Color(0xFFFEC107),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24, top: 18, bottom: 16),
                              child: GestureDetector(
                                onTap: initializeUser,
                                behavior: HitTestBehavior.opaque,
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/subscribe_background.png',
                            fit: BoxFit.contain,
                            height: 280,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    const Text(
                      'Watch new content',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Colors.black,
                        letterSpacing: -1.25
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'You will get access on our biweekly content. Explore podcast and articles as you want on your phone.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF020202),
                          letterSpacing: -.75
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFFF9900),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC6C7C6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC6C7C6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFC6C7C6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 48),
                    const Text(
                      'Starting at \$10.00/month',
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 16,
                          color: Color(0xFF6A6C6A),
                          letterSpacing: .25
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: AppButton(
                text: 'CONTINUE TO CHECKOUT',
                color: const Color(0xFF0150FF),
                radius: 40,
                onTap: initializeUser,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
