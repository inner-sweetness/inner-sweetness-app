import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/injection.dart';
import 'package:medito/providers/providers.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/edit_account/edit_account_screen.dart';
import 'package:medito/views/login/bloc/logic_bloc/login_bloc.dart';
import 'package:medito/views/login/login_view.dart';
import 'package:medito/views/submit_feedback/submit_feedback_screen.dart';
import 'package:medito/views/unsubscribe/unsubscribe_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final reminderTimeProvider = StateProvider<TimeOfDay?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return _getReminderTimeFromPrefs(prefs);
});

TimeOfDay? _getReminderTimeFromPrefs(SharedPreferences prefs) {
  final savedHour = prefs.getInt(SharedPreferenceConstants.savedHours);
  final savedMinute = prefs.getInt(SharedPreferenceConstants.savedMinutes);

  return (savedHour != null && savedMinute != null)
      ? TimeOfDay(hour: savedHour, minute: savedMinute)
      : null;
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SettingsItem> settingsItems = [
      SettingsItem(
        type: 'url',
        title: 'Edit account details',
        onTap: () => Navigator.of(context).push(
          FadePageRoute(
            builder: (context) => const EditAccountScreen(),
          ),
        ),
      ),
      SettingsItem(
        type: 'url',
        title: 'Share the application',
        onTap: () {},
      ),
      SettingsItem(
        type: 'url',
        title: 'Submit Feedback',
        onTap: () => Navigator.of(context).push(
          FadePageRoute(
            builder: (context) => const SubmitFeedbackScreen(),
          ),
        ),
      ),
    ];
    final loginBloc = getIt<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) async {
        if (state is LogoutSuccessState) {
          var canPop = Navigator.canPop(context);
          while(canPop) {
            await Navigator.maybePop(context);
            canPop = Navigator.canPop(context);
          }
          Navigator.of(context).pushReplacement(
            FadePageRoute(
              builder: (context) => const LoginView(),
            ),
          );
        }
      },
      child: Scaffold(
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
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
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
                const SizedBox(height: 32),
                const Text(
                  'Aaron Márquez',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'aaron@email.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF0150FF),
                    ),
                    child: const Text(
                      'Black Plan',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'MORE',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: settingsItems.map((item) => _buildMenuItemTile(context, item)).toList(),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    FadePageRoute(
                      builder: (context) => const UnsubscribeScreen(),
                    ),
                  ),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFFF9900)),
                      borderRadius: BorderRadius.circular(56),
                    ),
                    child: const Text(
                      'UNSUBSCRIBE',
                      style: TextStyle(
                        color: Color(0xFFFF9900),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => loginBloc.add(const Logout()),
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'LOG OUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItemTile(
      BuildContext context,
      SettingsItem item,
      ) {
    return GestureDetector(
      onTap: item.onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem {
  final String type;
  final String title;
  final VoidCallback onTap;

  const SettingsItem({
    required this.type,
    required this.title,
    required this.onTap,
  });
}
