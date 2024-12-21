import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medito/injection.dart';
import 'package:medito/views/edit_account/edit_account_content.dart';
import 'package:medito/views/edit_account/logic/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:medito/views/edit_account/logic/bloc/upload_profile_picture_bloc/upload_profile_picture_bloc.dart';
import 'package:medito/views/edit_account/logic/cubit/select_profile_image_cubit/select_profile_image_cubit.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';
import 'package:medito/views/settings/logic/bloc/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:medito/views/sign_up/cubits/select_country_cubit/select_country_cubit.dart';
import 'package:medito/views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<UploadProfilePictureBloc>(create: (context) => getIt<UploadProfilePictureBloc>()),
        BlocProvider<UpdateProfileBloc>(create: (context) => getIt<UpdateProfileBloc>()),
        BlocProvider<FetchProfileBloc>(create: (context) => getIt<FetchProfileBloc>()..fetch()),
        BlocProvider<SelectGenderCubit>(create: (context) => getIt<SelectGenderCubit>()),
        BlocProvider<SelectCountryCubit>(create: (context) => getIt<SelectCountryCubit>()),
        BlocProvider<ValidateNameCubit>(create: (context) => getIt<ValidateNameCubit>()),
        BlocProvider<ValidateLastnameCubit>(create: (context) => getIt<ValidateLastnameCubit>()),
        BlocProvider<ValidateEmailCubit>(create: (context) => getIt<ValidateEmailCubit>()),
        BlocProvider<ValidateAgeCubit>(create: (context) => getIt<ValidateAgeCubit>()),
        BlocProvider<SelectProfileImageCubit>(create: (context) => getIt<SelectProfileImageCubit>()),
      ],
      child: const EditAccountContent(),
    );
  }
}
