import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/onboarding/widgets/access_library/access_library.dart';
import 'package:medito/views/onboarding/widgets/newsletter/newsletter.dart';
import 'package:medito/views/onboarding/widgets/personalized_account/personalized_account.dart';
import 'package:medito/views/onboarding/widgets/support_love/support_love.dart';
import 'package:medito/views/onboarding/widgets/sweet_deals/sweet_deals.dart';
import 'package:medito/views/onboarding/widgets/whatsapp_channel/whatsapp_channel.dart';
import 'package:medito/views/subscribe/subscribe_view.dart';
import 'package:medito/widgets/buttons/app_button.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03F480),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * .7,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
            items: const <Widget>[
              AccessLibrary(),
              PersonalizedAccount(),
              WhatsappChannel(),
              Newsletter(),
              SupportLove(),
              SweetDeals(),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 0 ? const Color(0xFFF84BA6) : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 1 ? const Color(0xFFF84BA6) : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 2 ? const Color(0xFFF84BA6) : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 3 ? const Color(0xFFF84BA6) : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 4 ? const Color(0xFFF84BA6) : Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selectedIndex == 5 ? const Color(0xFFF84BA6) : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AppButton(
              text: 'SUBSCRIBE',
              radius: 40,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  FadePageRoute(
                    builder: (context) => const SubscribeView(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

