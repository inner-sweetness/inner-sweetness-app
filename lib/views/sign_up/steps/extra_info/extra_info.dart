import 'package:flutter/material.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/labeled_text_field.dart';

class ExtraInfo extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  const ExtraInfo({super.key, required this.onBack, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onBack,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 51),
                  Text(
                    'You are almost there!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF020202),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            color: Color(0xFF0150FF),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Material(
                            color: Color(0xFF0150FF),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Material(
                            color: Color(0xFF0150FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  LabeledTextField(
                    label: 'How old are you',
                    hint: 'Enter your age',
                  ),
                  SizedBox(height: 32),
                  LabeledTextField(
                    label: 'Where do you live',
                    hint: 'Select a country',
                  ),
                  SizedBox(height: 32),
                  LabeledTextField(
                    label: 'How you identify',
                    hint: 'Enter how you identify',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppButton(
              text: 'CONTINUE',
              color: const Color(0xFF0150FF),
              radius: 56,
              onTap: onContinue,
            ),
          ),
        ],
      ),
    );
  }
}
