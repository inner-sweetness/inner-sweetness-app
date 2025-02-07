import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/services/edition_service/models/response/edition_search_response.dart';
import 'package:medito/views/audio/audio_content.dart';
import 'package:medito/views/edition/logic/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:medito/views/edition/logic/bloc/delete_favorite_bloc/delete_favorite_bloc.dart';
import 'package:medito/views/edition/logic/cubit/set_favorite_cubit/set_favorite_cubit.dart';

class AudioView extends StatelessWidget {
  final EditionResponse edition;
  const AudioView({super.key, required this.edition});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<AddFavoriteBloc>(create: (context) => getIt<AddFavoriteBloc>()),
        BlocProvider<DeleteFavoriteBloc>(create: (context) => getIt<DeleteFavoriteBloc>()),
        BlocProvider<SetFavoriteCubit>(create: (context) => getIt<SetFavoriteCubit>()),
      ],
      child: AudioContent(edition: edition),
    );
  }
}
