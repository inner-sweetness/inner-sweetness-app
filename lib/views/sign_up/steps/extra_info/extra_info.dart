import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/views/sign_up/bloc/register_bloc/register_bloc.dart';
import 'package:medito/views/sign_up/cubits/select_country_cubit/select_country_cubit.dart';
import 'package:medito/views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart';
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 51),
                  const Text(
                    'You are almost there!',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                      color: Color(0xFF020202),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(
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
                  const SizedBox(height: 30),
                  BlocBuilder<ValidateAgeCubit, bool?>(
                    builder: (context, bool? isValidState) => LabeledTextField(
                      controller: context.read<RegisterBloc>().ageController,
                      label: 'How old are you',
                      hint: 'Enter your age',
                      error: isValidState == false ? 'Age is invalid' : '',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onFocusChange: (hasFocus, value) {
                        if (hasFocus) return;
                        context.read<ValidateAgeCubit>().validate(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<SelectCountryCubit, CountryCode?>(
                    builder: (context, CountryCode? countryState) => LabeledTextField(
                      label: 'Where do you live',
                      hint: countryState?.name ?? 'Select a country',
                      enabled: false,
                      onTap: () async {
                        const countryPicker = FlCountryCodePicker(
                          localize: true,
                          showDialCode: false,
                          showSearchBar: true,
                          countryTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          dialCodeTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                          searchBarTextStyle: TextStyle(
                            color: Colors.black,
                          ),
                        );
                        final country = await countryPicker.showPicker(context: context);
                        if (country == null) return;
                        context.read<SelectCountryCubit>().change(country);
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text(
                        'How you identify',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF020202),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<SelectGenderCubit, Genders?>(
                        builder: (context, Genders? genderState) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: Genders.values.map<Widget>((g) => GestureDetector(
                            onTap: () => context.read<SelectGenderCubit>().change(g),
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: g == genderState ? null : Border.all(color: Colors.black),
                                color: g == genderState ? Colors.blue : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                g.text,
                                style: TextStyle(
                                  color: g == genderState ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                    ],
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
