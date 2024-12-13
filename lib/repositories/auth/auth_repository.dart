import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/providers/providers.dart';
import 'package:medito/services/model/request/login_request.dart';
import 'package:medito/services/model/request/refresh_token_request.dart';
import 'package:medito/services/model/request/register_request.dart';
import 'package:medito/services/model/response/login_response.dart';
import 'package:medito/services/model/response/refresh_token_response.dart';
import 'package:medito/services/model/response/register_response.dart';
import 'package:medito/services/network/auth_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_repository.g.dart';

enum AuthException {
  accountMarkedForDeletion,
  other,
}

class AuthError implements Exception {
  final AuthException type;
  final String message;

  AuthError(this.type, this.message);

  @override
  String toString() => message;
}

abstract class AuthRepository {
  Future<String?> getClientIdFromSharedPreference();
  Future<void> initializeUser();
  Future<String> getToken();
  String getUserEmail();
  Future<RegisterResponse?> register(RegisterRequest request);
  Future<LoginResponse?> login(LoginRequest request);
  Future<RefreshTokenResponse?> refreshToken(RefreshTokenRequest request);
  Future<bool> signOut();
  Future<bool> markAccountForDeletion();
  Future<bool> isAccountMarkedForDeletion();
}

class AuthRepositoryImpl extends AuthRepository {
  final Ref ref;
  final AuthDioApiService service;

  AuthRepositoryImpl({required this.ref, required this.service});

  @override
  Future<void> initializeUser() async {
    throw Exception('Not implemented');
  }

  Future<void> _signInAnonymously(String clientId) async {
    throw Exception('Not implemented');
  }

  @override
  Future<String?> getClientIdFromSharedPreference() async {
    var prefs = ref.read(sharedPreferencesProvider);

    return prefs.getString(SharedPreferenceConstants.userId);
  }

  @override
  Future<String> getToken() async {
    throw Exception('Not implemented');
  }

  @override
  String getUserEmail() {
    throw Exception('Not implemented');
  }

  Future<void> _linkAnonymousAccount(String email, String password) async {
    throw Exception('Not implemented');
  }

  Future<void> _saveClientIdToSharedPreference(String clientId) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
        SharedPreferenceConstants.userId, clientId);
  }

  Future<void> _clearClientId() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove('client_id');
  }

  @override
  Future<bool> signOut() async {
    try {
      return true;
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  @override
  Future<bool> markAccountForDeletion() async {
    try {
      return false;
    } catch (e) {
      print('Error marking account for deletion: $e');
      return false;
    }
  }

  @override
  Future<bool> isAccountMarkedForDeletion() async {
    try {
      return false;
    } catch (e) {
      print('Error checking if account is marked for deletion: $e');
      return false;
    }
  }

  @override
  Future<LoginResponse?> login(LoginRequest request) async {
    try {
      final response = await service.login(request: request);
      var sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(SharedPreferenceConstants.userToken, response.accessToken);
      await sharedPreferences.setString(SharedPreferenceConstants.userRefreshToken, response.refreshToken);
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<RefreshTokenResponse?> refreshToken(RefreshTokenRequest request) async {
    try {
      final response = await service.refreshToken(request: request);
      var sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString(SharedPreferenceConstants.userToken, response.accessToken);
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<RegisterResponse?> register(RegisterRequest request) async {
    try {
      return await service.register(request: request);
    } catch (e) {
      return null;
    }
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(ref: ref, service: AuthDioApiService());
}
