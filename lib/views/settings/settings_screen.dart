import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/login/bloc/logic_bloc/login_bloc.dart';
import 'package:medito/views/settings/logic/bloc/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:medito/views/settings/settings_content.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<FetchProfileBloc>(create: (context) => getIt<FetchProfileBloc>()..fetch()),
        BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
      ],
      child: const SettingsContent(),
    );
  }


}
