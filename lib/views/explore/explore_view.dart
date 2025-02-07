import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/explore/explore_content.dart';
import 'package:medito/views/explore/logic/bloc/search_edition_bloc/search_edition_bloc.dart';
import 'package:medito/views/explore/logic/cubit/select_edition_category_cubit/select_edition_category_cubit.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchEditionBloc = getIt<SearchEditionBloc>();
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<SearchEditionBloc>(create: (context) => searchEditionBloc..add(const SearchEdition())),
        BlocProvider<SelectEditionCategoryCubit>(create: (context) => searchEditionBloc.selectEditionCategoryCubit),
      ],
      child: const ExploreContent(),
    );
  }
}
