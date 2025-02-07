import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/views/edit_account/logic/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:medito/views/edit_account/logic/bloc/upload_profile_picture_bloc/upload_profile_picture_bloc.dart';
import 'package:medito/views/login/cubit/validate_email_cubit/validate_email_cubit.dart';
import 'package:medito/views/settings/logic/bloc/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:medito/views/sign_up/cubits/select_country_cubit/select_country_cubit.dart';
import 'package:medito/views/sign_up/cubits/select_gender_cubit/select_gender_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_age_cubit/validate_age_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_lastname_cubit/validate_lastname_cubit.dart';
import 'package:medito/views/sign_up/cubits/validate_name_cubit/validate_name_cubit.dart';
import 'package:medito/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:medito/widgets/buttons/app_button.dart';
import 'package:medito/widgets/labeled_text_field/labeled_text_field.dart';
import 'package:medito/widgets/loading_overlay/app_loading_overlay.dart';

class EditAccountContent extends StatefulWidget {
  const EditAccountContent({super.key});

  @override
  State<EditAccountContent> createState() => _EditAccountContentState();
}

class _EditAccountContentState extends State<EditAccountContent> {
  final loading = DialogLoading();

  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, UpdateProfileState state) {
          loading.hide(context);
          if (state is UpdateProfileLoadingState) {
            loading.show(context);
          } else if (state is UpdateProfileErrorState) {
            AppSnackBar.showErrorSnackBar(context, message: state.message);
          } else if (state is UpdateProfileSuccessState) {
            AppSnackBar.showSuccessSnackBar(context, message: 'Account Updated.');
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFF0150FF),
          body: SafeArea(
            child: BlocBuilder<FetchProfileBloc, FetchProfileState>(
              builder: (context, FetchProfileState state) {
                if (state is FetchProfileLoadingState) {
                  return const Center(
                    child: SizedBox(
                      height: 64,
                      width: 64,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is FetchProfileSuccessState) {
                  nameController.text = state.response.data?.name ?? '';
                  lastnameController.text = state.response.data?.lastname ?? '';
                  emailController.text = state.response.data?.email ?? '';
                  ageController.text = '${state.response.data?.age ?? ""}';

                  context.read<SelectGenderCubit>().change(state.response.data?.genere.toGender);
                  context.read<SelectCountryCubit>().change(CountryCode.fromCode(state.response.data?.country == 'USA' ? 'US' : state.response.data?.country?.toLowerCase()));

                  context.read<ValidateNameCubit>().validate(nameController.text);
                  context.read<ValidateLastnameCubit>().validate(lastnameController.text);
                  context.read<ValidateEmailCubit>().validate(emailController.text);
                  context.read<ValidateAgeCubit>().validate(ageController.text);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        GestureDetector(
                          onTap: Navigator.of(context).maybePop,
                          behavior: HitTestBehavior.opaque,
                          child: const Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_back,
                                size: 24,
                                color: Colors.white,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Edit account details',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: SizedBox(
                            height: 101,
                            width: 92,
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Container(
                                    height: 92,
                                    width: 92,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: const Color(0x33FFFFFF), width: 4),
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          final path = await showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Colors.white,
                                            builder: (context) => Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final image = await ImagePicker().pickImage(source: ImageSource.camera);
                                                      if (image == null) return;
                                                      Navigator.of(context).pop(image.path);
                                                    },
                                                    behavior: HitTestBehavior.opaque,
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Icon(Icons.camera_alt, color: Colors.black),
                                                          SizedBox(width: 12),
                                                          Text('Camera', style: TextStyle(color: Colors.black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Divider(color: Colors.black),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                                      if (image == null) return;
                                                      Navigator.of(context).pop(image.path);
                                                    },
                                                    behavior: HitTestBehavior.opaque,
                                                    child: const Padding(
                                                      padding: EdgeInsets.all(16),
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Icon(Icons.image, color: Colors.black),
                                                          SizedBox(width: 12),
                                                          Text('Gallery', style: TextStyle(color: Colors.black)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                          if (path == null) return;
                                          context.read<UploadProfilePictureBloc>().add(UploadProfilePicture(path: path));
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: BlocBuilder<UploadProfilePictureBloc, UploadProfilePictureState>(
                                          builder: (context, UploadProfilePictureState uploadState) {
                                            if (uploadState is UploadProfilePictureLoadingState) {
                                              return const ClipOval(
                                                child: SizedBox(
                                                  height: 92,
                                                  width: 92,
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 46,
                                                      width: 46,
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            if (uploadState is UploadProfilePictureSuccessState) {
                                              return ClipOval(
                                                child: SizedBox(
                                                  height: 92,
                                                  width: 92,
                                                  child: Image.network(
                                                    '${HTTPConstants.baseUrl}/${uploadState.response}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (state.response.data?.avatar != null) {
                                              return ClipOval(
                                                child: SizedBox(
                                                  height: 92,
                                                  width: 92,
                                                  child: Image.network(
                                                    '${HTTPConstants.baseUrl}${state.response.data!.avatar!}',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            }
                                            return ClipOval(
                                              child: SizedBox(
                                                height: 92,
                                                width: 92,
                                                child: Image.asset(
                                                  'assets/images/profile_picture.jpeg',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: BlocBuilder<ValidateNameCubit, bool?>(
                                builder: (context, bool? isValidState) => LabeledTextField(
                                  controller: nameController,
                                  label: 'Name',
                                  labelColor: Colors.white,
                                  hint: 'Enter your first name',
                                  error: isValidState == false ? 'Name is invalid' : '',
                                  onFocusChange: (hasFocus, value) {
                                    if (hasFocus) return;
                                    context.read<ValidateNameCubit>().validate(value);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: BlocBuilder<ValidateLastnameCubit, bool?>(
                                builder: (context, bool? isValidState) => LabeledTextField(
                                  controller: lastnameController,
                                  label: 'Last name',
                                  labelColor: Colors.white,
                                  hint: 'Enter your last name',
                                  error: isValidState == false ? 'Lastname is invalid' : '',
                                  onFocusChange: (hasFocus, value) {
                                    if (hasFocus) return;
                                    context.read<ValidateLastnameCubit>().validate(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<ValidateEmailCubit, bool?>(
                          builder: (context, bool? isValidState) => LabeledTextField(
                            controller: emailController,
                            label: 'Email',
                            labelColor: Colors.white,
                            hint: 'Enter your email',
                            error: isValidState == false ? 'Email is invalid' : '',
                            onFocusChange: (hasFocus, value) {
                              if (hasFocus) return;
                              context.read<ValidateEmailCubit>().validate(value);
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: BlocBuilder<ValidateAgeCubit, bool?>(
                                builder: (context, bool? isValidState) => LabeledTextField(
                                  controller: ageController,
                                  label: 'Age',
                                  labelColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  hint: 'Enter your age',
                                  error: isValidState == false ? 'Age is invalid' : '',
                                  onFocusChange: (hasFocus, value) {
                                    if (hasFocus) return;
                                    context.read<ValidateAgeCubit>().validate(value);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            BlocBuilder<SelectGenderCubit, Genders?>(
                              builder: (context, Genders? genderState) => Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Gender',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: List.generate(Genders.values.length, (index) => GestureDetector(
                                      onTap: () => context.read<SelectGenderCubit>().change(Genders.values[index]),
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        margin: index > 0 ? const EdgeInsets.only(left: 12) : null,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                        decoration: BoxDecoration(
                                          border: Genders.values[index] == genderState ? null : Border.all(color: const Color(0xFFD6D6D6)),
                                          color: Genders.values[index] == genderState ? const Color(0xFFFFF500) : Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          Genders.values[index].text,
                                          style: const TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<SelectCountryCubit, CountryCode?>(
                          builder: (context, CountryCode? countryState) => LabeledTextField(
                            label: 'Where do you live',
                            labelColor: Colors.white,
                            controller: TextEditingController(text: countryState?.name),
                            hint: 'Select a country',
                            enabled: false,
                            onTap: () async {
                              const countryPicker = FlCountryCodePicker(
                                localize: true,
                                showDialCode: false,
                                showSearchBar: true,
                                countryTextStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                dialCodeTextStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                searchBarTextStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              );
                              final country = await countryPicker.showPicker(context: context);
                              if (country == null) return;
                              context.read<SelectCountryCubit>().change(country);
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        BlocBuilder<ValidateNameCubit, bool?>(
                          builder: (context, bool? validName) => BlocBuilder<ValidateLastnameCubit, bool?>(
                            builder: (context, bool? validLastname) => BlocBuilder<ValidateEmailCubit, bool?>(
                              builder: (context, bool? validEmail) => BlocBuilder<ValidateAgeCubit, bool?>(
                                builder: (context, bool? validAge) => AppButton(
                                  color: const Color(0xFFFFF500),
                                  fontColor: Colors.black,
                                  text: 'UPDATE',
                                  radius: 56,
                                  onTap: validName == true && validLastname == true && validEmail == true && validAge == true ? () => context.read<UpdateProfileBloc>().add(
                                    UpdateProfile(
                                      name: nameController.text.trim(),
                                      lastname: lastnameController.text.trim(),
                                      email: emailController.text.trim(),
                                      age: int.tryParse(ageController.text.trim()) ?? 0,
                                      country: context.read<SelectCountryCubit>().state?.code ?? 'US',
                                      gender: context.read<SelectGenderCubit>().state?.text ?? 'Male',
                                    ),
                                  ) : null,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
