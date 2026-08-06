import 'package:deenlink/core/services/onboarding_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';
import '../repositories/auth_remote_repository.dart';

enum AppDestination { onboarding, login, home }

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final authRepositoryProvider = Provider<AuthRemoteRepository>((ref) {
  return AuthRemoteRepository();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRemoteRepository _repository;

  AuthNotifier(this._repository) : super(AuthInitial()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = AuthLoading();
    try {
      final user = await _repository.getCurrentUser();
      if (user != null) {
        state = AuthAuthenticated(user);
      } else {
        state = AuthUnauthenticated();
      }
    } catch (_) {
      state = AuthUnauthenticated();
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = AuthLoading();
    try {
      final user = await _repository.login(email: email, password: password);
      state = AuthAuthenticated(user);
    } catch (e) {
      state = AuthError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> register({
    required String fullname,
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
    required bool agreeToTerms,
  }) async {
    state = AuthLoading();
    try {
      final user = await _repository.register(
        fullname: fullname,
        email: email,
        username: username,
        password: password,
        confirmPassword: confirmPassword,
        agreeToTerms: agreeToTerms,
      );
      state = AuthAuthenticated(user);
    } catch (e) {
      state = AuthError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthUnauthenticated();
  }

  User? get currentUser {
    final s = state;
    if (s is AuthAuthenticated) return s.user;
    return null;
  }

  void setUser(User user) {
    state = AuthAuthenticated(user);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authProvider);
  if (authState is AuthAuthenticated) return authState.user;
  return null;
});

final appStartDestinationProvider = FutureProvider<AppDestination>((ref) async {
  final hasSeen = await OnboardingService.hasSeen();
  if (!hasSeen) return AppDestination.onboarding;

  try {
    final repo = ref.read(authRepositoryProvider);
    final user = await repo.getCurrentUser();
    if (user != null) {
      ref.read(authProvider.notifier).setUser(user);
      return AppDestination.home;
    }
  } catch (_) {}
  return AppDestination.login;
});
