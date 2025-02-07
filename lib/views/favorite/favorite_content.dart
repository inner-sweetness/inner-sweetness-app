import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/favorite/logic/bloc/fetch_favorites_bloc/fetch_favorites_bloc.dart';
import 'package:medito/views/favorite/logic/cubit/filter_favorite_cubit/filter_favorite_cubit.dart';
import 'package:medito/views/favorite/widgets/favorite_list/favorite_list.dart';
import 'package:medito/views/settings/settings_screen.dart';
import 'package:medito/widgets/labeled_text_field/app_debounced_text_field.dart';

class FavoriteContent extends StatefulWidget {
  const FavoriteContent({super.key});

  @override
  State<FavoriteContent> createState() => _FavoriteContentState();
}

class _FavoriteContentState extends State<FavoriteContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 36,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFFF9900),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Enjoy all your',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'favorites',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      FadePageRoute(builder: (context) => const SettingsScreen()),
                    ),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'DN',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<FetchFavoritesBloc, FetchFavoritesState>(
              builder: (context, FetchFavoritesState state) {
                if (state is FetchFavoritesLoadingState) {
                  return const Center(
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is FetchFavoritesSuccessState) {
                  final list = state.items;
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: AppDebouncedTextField(
                          onDebounceChanged: context.read<FilterFavoriteCubit>().change,
                          borderColor: Colors.transparent,
                          fillColor: const Color(0xFF383838),
                          hint: 'Search',
                          fontColor: Colors.white,
                          prefix: const SizedBox(
                            height: 24,
                            width: 24,
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: BlocBuilder<FilterFavoriteCubit, String>(
                          builder: (context, String filterState) {
                            final filtered = list.where((e) => e.edition?.title?.toLowerCase().contains(filterState.toLowerCase()) ?? false).toList();
                            return FavoriteList(items: filtered);
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
