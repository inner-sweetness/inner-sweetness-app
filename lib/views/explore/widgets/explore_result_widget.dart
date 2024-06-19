import 'dart:async';

import 'package:Medito/constants/constants.dart';
import 'package:Medito/providers/providers.dart';
import 'package:Medito/routes/routes.dart';
import 'package:Medito/utils/utils.dart';
import 'package:Medito/widgets/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'explore_result_card_widget.dart';

class ExploreResultWidget extends ConsumerStatefulWidget {
  const ExploreResultWidget({super.key});

  @override
  _ExploreResultWidgetState createState() => _ExploreResultWidgetState();
}

class _ExploreResultWidgetState extends ConsumerState<ExploreResultWidget> {
  var isConnected = true;
  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> event) {
      isConnected = !event.contains(ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var exploreResult = ref.watch(exploreProvider);
    var exploreQuery = ref.watch(exploreQueryProvider);
    var listViewPadding = EdgeInsets.only(
      top: padding20,
      bottom: padding16,
      left: padding16,
      right: padding16,
    );

    return exploreResult.when(
      data: (data) {
        if (data.message != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text(
              data.message.toString(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                letterSpacing: 0,
                color: ColorConstants.walterWhite,
                fontSize: 14,
              ),
            ),
          );
        }

        return ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: listViewPadding,
          itemBuilder: (BuildContext context, int index) {
            var element = data.items[index];

            return ExploreResultCardWidget(
              title: element.category,
              description: element.title,
              coverUrlPath: element.coverUrl,
              onTap: () =>
                  _handleTap(context, element.id, element.type, element.path),
            );
          },
          itemCount: data.items.length,
        );
      },
      error: (err, stack) => MeditoErrorWidget(
        message: err.toString(),
        onTap: () => ref.refresh(exploreProvider),
        isLoading: exploreResult.isLoading,
      ),
      loading: () {
        if (exploreQuery.hasExploreStarted) {
          return const ExploreResultShimmerWidget();
        }

        return SizedBox();
      },
    );
  }

  void _handleTap(
      BuildContext context,
      String id,
      String type,
      String path,
      ) {
    if (isConnected) {
      handleNavigation(
        type,
        [id.toString(), path],
        context,
      );
    } else {
      createSnackBar(StringConstants.checkConnection, context);
    }
  }
}