import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/views/bottom_navigation/bottom_navigation_item.dart';
import 'package:medito/views/explore/explore_view.dart';
import 'package:medito/views/favorite/favorite_view.dart';
import 'package:medito/views/home/home_view.dart';
import 'package:medito/views/player/widgets/bottom_actions/bottom_action_bar.dart';

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
      const ExploreView(),
      const FavoriteView(),
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
              child: BottomNavigationItem(
                icon: _currentPageIndex == 0 ? Icons.home : Icons.home_outlined,
                label: 'Home',
                selected: _currentPageIndex == 0,
              ),
              onTap: () => _onDestinationSelected(0),
            ),
            BottomActionBarItem(
              child: BottomNavigationItem(
                icon: _currentPageIndex == 1 ? Icons.search : Icons.search_outlined,
                label: 'Search',
                selected: _currentPageIndex == 1,
              ),
              onTap: () => _onDestinationSelected(1),
            ),
            BottomActionBarItem(
              child: BottomNavigationItem(
                icon: _currentPageIndex == 2 ? Icons.favorite : Icons.favorite_outline,
                label: 'Favorites',
                selected: _currentPageIndex == 2,
              ),
              onTap: () => _onDestinationSelected(2),
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
