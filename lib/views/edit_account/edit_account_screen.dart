import 'package:flutter/material.dart';
import 'package:medito/widgets/labeled_text_field/labeled_text_field.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: Navigator.of(context).maybePop,
                behavior: HitTestBehavior.opaque,
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.white,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Edit account details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: SizedBox(
                  height: 132,
                  width: 148,
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 132,
                          width: 132,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0x33FFFFFF), width: 4),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Center(
                            child: ClipOval(
                              child: SizedBox(
                                height: 124,
                                width: 124,
                                child: Image.asset(
                                  'assets/images/profile_picture.jpeg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: LabeledTextField(
                      label: 'First name',
                      hint: 'Enter your first name',
                      value: 'Aaron',
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: LabeledTextField(
                      label: 'Last name',
                      hint: 'Enter your last name',
                      value: 'Márquez',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const LabeledTextField(
                label: 'Email',
                hint: 'Enter your email',
                value: 'aaron@gmail.com',
              ),
              const SizedBox(height: 24),
              const LabeledTextField(
                label: 'Phone',
                hint: 'Enter your phone',
                value: '+51 954 232 255',
              ),
              const SizedBox(height: 24),
              const LabeledTextField(
                label: 'Birthday',
                hint: 'Enter your birthday',
                value: 'Dec / 14 / 1987',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
