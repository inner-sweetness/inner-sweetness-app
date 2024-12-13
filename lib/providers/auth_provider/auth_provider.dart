import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medito/repositories/auth/auth_repository.dart';
import 'package:medito/services/model/request/login_request.dart';
import 'package:medito/services/model/request/register_request.dart';
import 'package:medito/services/model/response/login_response.dart';
import 'package:medito/services/model/response/register_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;

  LoginState({
    required this.email,
    required this.password,
    this.isLoading = false,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginState(email: '', password: ''));

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future<void> login() async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(error: "Email and password cannot be empty");
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    // Simulate a login process
    await Future.delayed(Duration(seconds: 2));

    if (state.email == "test@example.com" && state.password == "password") {
      state = state.copyWith(isLoading: false);
      // Login successful
    } else {
      state = state.copyWith(
        isLoading: false,
        error: "Invalid email or password",
      );
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});

@riverpod
Future<LoginResponse?> login(AuthRepositoryRef ref, LoginRequest request) async {
  final authRepository = ref.watch(authRepositoryProvider);
  ref.keepAlive();

  return await authRepository.login(request);
}

@riverpod
Future<RegisterResponse?> signUp(AuthRepositoryRef ref, RegisterRequest request) async {
  final authRepository = ref.watch(authRepositoryProvider);
  ref.keepAlive();

  return await authRepository.register(request);
}