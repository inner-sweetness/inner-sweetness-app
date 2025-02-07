import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/home/logic/bloc/fetch_app_bloc/fetch_app_bloc.dart';
import 'package:medito/views/home/logic/bloc/fetch_network_bloc/fetch_network_bloc.dart';
import 'package:medito/views/home/widgets/home_logo.dart';
import 'package:medito/views/home/widgets/home_media/home_legal.dart';
import 'package:medito/views/home/widgets/home_media/home_networks.dart';

class HomeMedia extends StatelessWidget {
  const HomeMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<FetchNetworkBloc>(create: (context) => getIt<FetchNetworkBloc>()..fetch()),
        BlocProvider<FetchAppBloc>(create: (context) => getIt<FetchAppBloc>()..fetch()),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HomeLogo(),
            SizedBox(height: 32),
            HomeLegal(),
            SizedBox(height: 32),
            HomeNetworks(),
          ],
        ),
      ),
    );
  }
}
