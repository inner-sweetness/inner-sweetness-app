import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/models/models.dart';
import 'package:medito/widgets/widgets.dart';

import '../../providers/home/home_provider.dart';
import 'widgets/bottom_sheet/stats/stats_bottom_sheet_widget.dart';
import 'widgets/editorial/carousel_widget.dart';
import 'widgets/header_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final home = ref.watch(fetchHomeProvider);

    return home.when(
      loading: () => const HomeShimmerWidget(),
      error: (err, stack) => MeditoErrorWidget(
        message: home.error.toString(),
        onTap: () => _onRefresh(),
        isLoading: home.isLoading,
      ),
      data: (HomeModel homeData) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 56.0,
            title: HeaderWidget(
              greeting: homeData.title ?? StringConstants.welcome,
              onStatsButtonTap: () => _onStatsButtonTapped(context),
            ),
            elevation: 0.0,
          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (homeData.subTitle?.isNotEmpty ?? false)
                   ...[
                     const SizedBox(height: 24),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 16),
                       child: Text(
                         homeData.subTitle ?? '',
                         style:
                         Theme.of(context).textTheme.headlineMedium?.copyWith(
                           color: ColorConstants.white,
                           height: 0,
                           fontSize: 24,
                           fontWeight: FontWeight.w500,
                           fontFamily: SourceSerif,
                         ),
                       ),
                     ),
                   ],
                  CarouselWidget(carouselItems: homeData.carousel),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh() async {
    ref.invalidate(fetchLatestAnnouncementProvider);
    await ref.read(fetchLatestAnnouncementProvider.future);
    ref.invalidate(refreshHomeAPIsProvider);
    await ref.read(refreshHomeAPIsProvider.future);
  }

  void _onStatsButtonTapped(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: ColorConstants.onyx,
      builder: (BuildContext context) {
        return const StatsBottomSheetWidget();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
