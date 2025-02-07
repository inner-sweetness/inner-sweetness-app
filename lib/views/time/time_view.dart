import 'package:medito/models/time/time_model.dart';
import 'package:medito/widgets/markdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/colors/color_constants.dart';
import '../../constants/strings/string_constants.dart';

class TimeView extends ConsumerStatefulWidget {
  const TimeView({super.key, required this.timeModel});

  final TimeModel timeModel;

  @override
  ConsumerState createState() => _TimeViewState();
}

class _TimeViewState extends ConsumerState<TimeView> {
  @override
  Widget build(BuildContext context) {
    var markDownTheme = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: ColorConstants.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            const Text(
              StringConstants.hey,
            ),
            const SizedBox(
              height: 12,
            ),
            MarkdownWidget(
              body: 'El tiempo de prueba de la App ha expirado',
              textAlign: WrapAlignment.start,
              a: markDownTheme?.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w700,
              ),
              p: markDownTheme?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
