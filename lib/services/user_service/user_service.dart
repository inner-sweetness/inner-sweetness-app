import 'package:injectable/injectable.dart';
import 'package:medito/services/user_service/models/request/update_profile_request.dart';
import 'package:medito/services/user_service/models/response/profile_response.dart';
import 'package:medito/services/user_service/user_repository.dart';

@injectable
class UserServices {
  final IUserRepository _repository;

  UserServices(this._repository);

  Future<ProfileResponse> fetchProfile() => _repository.fetchProfile();
  Future<String> uploadProfilePicture({required String path}) => _repository.uploadProfilePicture(path: path);
  Future<ProfileResponse> updateProfile({required UpdateProfileRequest request}) => _repository.updateProfile(request: request);
}