import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/views/home/logic/bloc/fetch_app_bloc/fetch_app_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeLegal extends StatelessWidget {
  const HomeLegal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAppBloc, FetchAppState>(
      builder: (context, FetchAppState state) {
        if (state.isLoading) {
          return const Center(child: SizedBox(height: 24, child: CircularProgressIndicator()));
        } else if (state.hasError) {
          return Center(
            child: Text(
              state.error,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        String? termsURL, privacyUrl;
        final response = state.response;
        if (response != null) {
          termsURL = response.data?.termsUrl;
          privacyUrl = response.data?.privacyUrl;
        }
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: termsURL != null ? () => launchUrl(Uri.parse(termsURL!)) : null,
              behavior: HitTestBehavior.opaque,
              child: const Text(
                'TERMS & CONDITIONS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              height: 14,
              width: 1,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: privacyUrl != null ? () => launchUrl(Uri.parse(privacyUrl!)) : null,
              behavior: HitTestBehavior.opaque,
              child: const Text(
                'PRIVACY POLICY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
