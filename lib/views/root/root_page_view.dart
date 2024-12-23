import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/di/app_config.dart';
import 'package:medito/injection.dart';
import 'package:medito/providers/root/root_combine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart';

class RootPageView extends ConsumerStatefulWidget {
  final Widget firstChild;

  const RootPageView({super.key, required this.firstChild});

  @override
  ConsumerState<RootPageView> createState() => _RootPageViewState();
}

class _RootPageViewState extends ConsumerState<RootPageView> {
  @override
  void initState() {
    super.initState();
    ref.read(rootCombineProvider(context));
  }

  @override
  Widget build(BuildContext context) {
    getIt<AppConfig>().context = context;
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<FetchFavoritesBloc>(create: (context) => getIt<FetchFavoritesBloc>()),
      ],
      child: Scaffold(
        backgroundColor: ColorConstants.black,
        resizeToAvoidBottomInset: false,
        body: NotificationListener<ScrollNotification>(
          child: PageView(
            scrollDirection: Axis.vertical,
            physics: const ClampingScrollPhysics(),
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  widget.firstChild,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
