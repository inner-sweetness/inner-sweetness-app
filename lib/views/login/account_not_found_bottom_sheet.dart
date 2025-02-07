import 'package:flutter/material.dart';
import 'package:medito/widgets/buttons/app_button.dart';

class AccountNotFoundBottomSheet extends StatelessWidget {
  const AccountNotFoundBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              "We can’t find your account",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
                letterSpacing: -.25,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Try another email address, or if you don’t have an account, you can create a new one.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Color(0xFF020202),
                letterSpacing: -.25,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'TRY AGAIN',
            radius: 56,
            borderColor: const Color(0xFF0150FF),
            color: Colors.white,
            fontColor: const Color(0xFF0150FF),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'SIGN UP',
            radius: 56,
            color: const Color(0xFF0150FF),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

void showAccountNotFoundBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    builder: (context) => const AccountNotFoundBottomSheet(),
  );
}
