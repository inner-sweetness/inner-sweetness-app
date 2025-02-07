import 'package:injectable/injectable.dart';
import 'package:medito/constants/http/http_constants.dart';
import 'package:medito/network/dio_client.dart';
import 'package:medito/services/user_service/models/request/update_profile_request.dart';
import 'package:medito/services/user_service/models/response/profile_response.dart';

abstract class IUserRepository {
  Future<ProfileResponse> fetchProfile();
  Future<String> uploadProfilePicture({required String path});
  Future<ProfileResponse> updateProfile({required UpdateProfileRequest request});
}

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  @override
  Future<ProfileResponse> fetchProfile() async {
    final response = await _dioClient.get('${HTTPConstants.baseUrl}/user/profile');
    return ProfileResponse.fromJson(response.data as Map<String, Object?>);
  }

  @override
  Future<String> uploadProfilePicture({required String path}) async {
    final response = await _dioClient.upload(
      '${HTTPConstants.baseUrl}/user/profile/avatar',
      path: path,
    );
    return (response.data as Map)['data'] as String;
  }

  @override
  Future<ProfileResponse> updateProfile({required UpdateProfileRequest request}) async {
    final response = await _dioClient.put(
      '${HTTPConstants.baseUrl}/user/profile',
      body: request.toJson(),
    );
    return ProfileResponse.fromJson(response.data as Map<String, Object?>);
  }
}