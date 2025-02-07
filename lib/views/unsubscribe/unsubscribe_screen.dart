import 'package:flutter/material.dart';
import 'package:medito/views/unsubscribe/unsubscribe_option.dart';

class UnsubscribeScreen extends StatelessWidget {
  const UnsubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: Navigator.of(context).maybePop,
                behavior: HitTestBehavior.opaque,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 64),
              const Text(
                'We will miss you a lot',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'By unsubscribing, you’ll stop receiving this benefits:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              const UnsubscribeOption(
                text: 'Sed ut perspiciatis unde omnis iste error sit voluptatem',
              ),
              const UnsubscribeOption(
                text: 'Sed ut perspiciatis unde omnis iste error sit voluptatem',
              ),
              const UnsubscribeOption(
                text: 'Sed ut perspiciatis unde omnis iste error sit voluptatem',
              ),
              const UnsubscribeOption(
                text: 'Sed ut perspiciatis unde omnis iste error sit voluptatem',
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'UNSUBSCRIBE ME',
                  style: TextStyle(
                    color: Color(0xFFFF9900),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9900),
                  borderRadius: BorderRadius.circular(56),
                ),
                child: const Text(
                  'I WILL STAY',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
