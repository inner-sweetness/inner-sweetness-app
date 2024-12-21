import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/edit_account/edit_account_screen.dart';
import 'package:medito/views/login/bloc/logic_bloc/login_bloc.dart';
import 'package:medito/views/login/login_view.dart';
import 'package:medito/views/settings/logic/bloc/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:medito/views/submit_feedback/submit_feedback_screen.dart';
import 'package:medito/views/unsubscribe/unsubscribe_screen.dart';

class SettingsContent extends StatefulWidget {
  const SettingsContent({super.key});

  @override
  State<SettingsContent> createState() => _SettingsContentState();
}

class _SettingsContentState extends State<SettingsContent> {
  @override
  Widget build(BuildContext context) {
    final List<SettingsItem> settingsItems = [
      SettingsItem(
        type: 'url',
        title: 'Edit account details',
        onTap: () async {
          await Navigator.of(context).push(
            FadePageRoute(
              builder: (context) => const EditAccountScreen(),
            ),
          );
          context.read<FetchProfileBloc>().add(const FetchProfile());
        },
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
    return BlocListener<LoginBloc, LoginState>(
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
        backgroundColor: const Color(0xFF0150FF),
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
                BlocBuilder<FetchProfileBloc, FetchProfileState>(
                  builder: (context, FetchProfileState state) {
                    if (state is FetchProfileLoadingState) {
                      return const SizedBox(
                        height: 128,
                        width: 64,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is FetchProfileSuccessState) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
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
                                  child: state.response.data?.avatar != null ? Image.network(
                                    '${HTTPConstants.baseUrl}/${state.response.data!.avatar!}',
                                    fit: BoxFit.cover,
                                  ) : Image.asset(
                                    'assets/images/profile_picture.jpeg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            state.response.data?.name ?? '',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            state.response.data?.email ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
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
                  onTap: () => context.read<LoginBloc>().add(const Logout()),
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
