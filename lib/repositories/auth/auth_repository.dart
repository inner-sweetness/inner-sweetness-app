import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/constants/constants.dart';
import 'package:medito/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

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
  User? get currentUser;
  Future<bool> signOut();
  Future<bool> markAccountForDeletion();
  Future<bool> isAccountMarkedForDeletion();
}

class AuthRepositoryImpl extends AuthRepository {
  final Ref ref;

  AuthRepositoryImpl({required this.ref});

  @override
  Future<void> initializeUser() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
    );

    var clientId = await getClientIdFromSharedPreference();
    clientId ??= const Uuid().v4();

    await _saveClientIdToSharedPreference(clientId);
    if (Supabase.instance.client.auth.currentUser == null) {
      await _signInAnonymously(clientId);
    }
  }

  Future<void> _signInAnonymously(String clientId) async {
    try {
      await Supabase.instance.client.auth.signInAnonymously(
        data: {'client_id': clientId},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<String?> getClientIdFromSharedPreference() async {
    var prefs = ref.read(sharedPreferencesProvider);

    return prefs.getString(SharedPreferenceConstants.userId);
  }

  @override
  Future<String> getToken() async {
    var currentSession = Supabase.instance.client.auth.currentSession;
    if (currentSession != null) {
      var bearer = currentSession.accessToken;

      return bearer.isNotEmpty
          ? bearer
          : throw Exception('No bearer token found');
    }

    return '';
  }

  @override
  String getUserEmail() {
    var currentUser = Supabase.instance.client.auth.currentUser;

    return currentUser?.email ?? '';
  }

  @override
  Future<bool> signUp(String email, String password) async {
    var clientId = await getClientIdFromSharedPreference() ?? '';
    var supabase = Supabase.instance.client;

    try {
      var signUpResponse = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'client_id': clientId},
      );

      if (signUpResponse.user != null) {
        await _linkAnonymousAccount(email, password);
      }

      return signUpResponse.user != null;
    } catch (e) {
      throw Exception('Error during sign-up: ${e.toString()}');
    }
  }

  @override
  Future<bool> logIn(String email, String password) async {
    var supabase = Supabase.instance.client;

    _clearClientId();

    try {
      var response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        if (response.user?.userMetadata?['marked_for_deletion'] == true) {
          throw AuthError(AuthException.accountMarkedForDeletion, 
            'This account has been marked for deletion.');
        }
        await _saveClientIdToSharedPreference(
            response.user?.userMetadata?['client_id'] ?? '');
      }

      return response.user != null;
    } catch (e) {
      if (e is AuthError) {
        rethrow;
      }
      throw AuthError(AuthException.other, 'Error during log-in: ${e.toString()}');
    }
  }

  Future<void> _linkAnonymousAccount(String email, String password) async {
    var supabase = Supabase.instance.client;
    var anonymousUser = supabase.auth.currentUser;

    if (anonymousUser != null && anonymousUser.email == null) {
      try {
        await supabase.auth.updateUser(
          UserAttributes(
            email: email,
            password: password,
          ),
        );
      } catch (e) {
        throw Exception('Error linking anonymous account: ${e.toString()}');
      }
    }
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
  User? get currentUser => Supabase.instance.client.auth.currentUser;

  @override
  Future<bool> signOut() async {
    var supabase = Supabase.instance.client;

    try {
      await supabase.auth.signOut();

      var newClientId = const Uuid().v4();
      await _saveClientIdToSharedPreference(newClientId);

      await _signInAnonymously(newClientId);

      return true;
    } catch (e) {
      throw Exception('Error signing out: ${e.toString()}');
    }
  }

  @override
  Future<bool> markAccountForDeletion() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.auth.updateUser(
        UserAttributes(data: {'marked_for_deletion': true}),
      );
      return response.user != null;
    } catch (e) {
      print('Error marking account for deletion: $e');
      return false;
    }
  }

  @override
  Future<bool> isAccountMarkedForDeletion() async {
    try {
      final supabase = Supabase.instance.client;
      final user = supabase.auth.currentUser;
      return user?.userMetadata?['marked_for_deletion'] == true;
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
