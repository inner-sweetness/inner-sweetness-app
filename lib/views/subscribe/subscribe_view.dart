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
    // await Navigator.of(context).pushReplacement(
    //   FadePageRoute(
    //     builder: (context) => const RootPageView(
    //       firstChild: BottomNavigationBarView(),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03F480),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: initializeUser,
                  behavior: HitTestBehavior.opaque,
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
            const Text(
              'If it resonates',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF0150FF),
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Subscribe!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 36),
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '\$',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 32,
                        color: Color(0xFF0150FF),
                        height: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '5.55',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 64,
                        color: Color(0xFF0150FF),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Text(
                  '/month',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Color(0xFF0150FF),
                    height: 3.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 36),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 39),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'And you will receive our fresh hand crafted content',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    TextSpan(
                      text: ' every two weeks.',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: Image.asset(
                'assets/images/subscription_image.png',
                fit: BoxFit.cover,
                width: 255,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppButton(
                text: 'PAY NOW!',
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
