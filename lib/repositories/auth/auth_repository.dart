import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/providers/providers.dart';
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
  Future<bool> signUp(String email, String password);
  Future<bool> logIn(String email, String password);
  Future<bool> signOut();
  Future<bool> markAccountForDeletion();
  Future<bool> isAccountMarkedForDeletion();
}

class AuthRepositoryImpl extends AuthRepository {
  final Ref ref;

  AuthRepositoryImpl({required this.ref});

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

  @override
  Future<bool> signUp(String email, String password) async {
    throw Exception('Not implemented');
  }

  @override
  Future<bool> logIn(String email, String password) async {
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
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(ref: ref);
}
