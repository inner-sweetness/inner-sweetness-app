import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medito/views/home/widgets/home_logo.dart';

class HomeMedia extends StatelessWidget {
  const HomeMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const HomeLogo(),
          const SizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'TERMS & CONDITIONS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(width: 12),
              Container(
                height: 14,
                width: 1,
                color: Colors.white,
              ),
              const SizedBox(width: 12),
              const Text(
                'PRIVACY POLICY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/images/instagram.svg'),
              SvgPicture.asset('assets/images/linkedin.svg'),
              SvgPicture.asset('assets/images/spotify.svg'),
              SvgPicture.asset('assets/images/youtube.svg'),
              SvgPicture.asset('assets/images/tiktok.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
