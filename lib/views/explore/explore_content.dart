import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/services/edition_service/models/request/edition_search_request.dart';
import 'package:medito/utils/fade_page_route.dart';
import 'package:medito/views/explore/logic/bloc/search_edition_bloc/search_edition_bloc.dart';
import 'package:medito/views/explore/logic/cubit/select_edition_category_cubit/select_edition_category_cubit.dart';
import 'package:medito/views/explore/widgets/explore_text_field.dart';
import 'package:medito/views/settings/settings_screen.dart';
import 'package:medito/widgets/labeled_text_field/app_debounced_text_field.dart';

import 'widgets/explore_category_list/explore_category_list.dart';
import 'widgets/explore_result_list/explore_result_list.dart';

class ExploreContent extends StatefulWidget {
  const ExploreContent({super.key});

  @override
  State<ExploreContent> createState() => _ExploreContentState();
}

class _ExploreContentState extends State<ExploreContent> {
  final searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectEditionCategoryCubit, EditionSearchCategory?>(
      listener: (context, EditionSearchCategory? categoryState)
        => context.read<SearchEditionBloc>().add(const SearchEdition()),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E1E1E),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 36, left: 24, right: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
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
                    const Text(
                      'Browse',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        FadePageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      ),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'DN',
                            style: TextStyle(
                              fontSize: 14,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 32),
                    AppDebouncedTextField(
                      controller: context.read<SearchEditionBloc>().queryController,
                      borderColor: Colors.transparent,
                      fillColor: const Color(0xFF383838),
                      hint: 'Search',
                      fontColor: Colors.white,
                      onDebounceChanged: (_) => context.read<SearchEditionBloc>().add(const SearchEdition()),
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
                    const SizedBox(height: 32),
                    BlocBuilder<SelectEditionCategoryCubit, EditionSearchCategory?>(
                      builder: (context, EditionSearchCategory? categoryState) => ExploreCategoryList(
                        selected: categoryState,
                        onCategorySelect: context.read<SelectEditionCategoryCubit>().change,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: BlocBuilder<SearchEditionBloc, SearchEditionState>(
                        builder: (context, SearchEditionState state) {
                          if (state is SearchEditionLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is SearchEditionSuccessState || state is SearchEditionLoadingNextState) {
                            return ExploreResultList(
                              items: context.read<SearchEditionBloc>().editions,
                              isLoading: state is SearchEditionLoadingNextState,
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
