import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/views/explore/widgets/explore_view.dart';
import 'package:medito/views/home/home_view.dart';
import 'package:medito/views/player/widgets/bottom_actions/bottom_action_bar.dart';
import 'package:medito/widgets/medito_huge_icon.dart';

class BottomNavigationBarView extends ConsumerStatefulWidget {
  const BottomNavigationBarView({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState
    extends ConsumerState<BottomNavigationBarView> {
  var _currentPageIndex = 0;
  final _searchFocusNode = FocusNode();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeView(),
      ExploreView(searchFocusNode: _searchFocusNode),
    ];
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentPageIndex == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onDestinationSelected(0);
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomActionBar(
          children: <BottomActionBarItem>[
            BottomActionBarItem(
              child: MeditoHugeIcon(
                icon: _currentPageIndex == 0 ? 'filledhome' : 'duohome',
                color: _currentPageIndex == 0
                    ? ColorConstants.lightPurple
                    : ColorConstants.white,
              ),
              onTap: () => _onDestinationSelected(0),
            ),
            BottomActionBarItem(
              child: GestureDetector(
                onDoubleTap: () {
                  if (_currentPageIndex == 1) {
                    _searchFocusNode.requestFocus();
                  } else {
                    _onDestinationSelected(1);
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _searchFocusNode.requestFocus();
                    });
                  }
                },
                child: MeditoHugeIcon(
                  icon: _currentPageIndex == 1 ? 'filledSearch' : 'duoSearch',
                  color: _currentPageIndex == 1
                      ? ColorConstants.lightPurple
                      : ColorConstants.white,
                ),
              ),
              onTap: () => _onDestinationSelected(1),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentPageIndex,
          children: _pages,
        ),
      ),
    );
  }

  void _onDestinationSelected(int index) {
    if (_currentPageIndex == 1 && index != 1) {
      _searchFocusNode.unfocus();
    }
    setState(() {
      _currentPageIndex = index;
    });
  }
}
