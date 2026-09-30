import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthTab { signIn, createAccount }

class AuthTabNotifier extends Notifier<AuthTab> {
  @override
  AuthTab build() => AuthTab.signIn;

  void setTab(AuthTab tab) => state = tab;
}

final authTabProvider = NotifierProvider<AuthTabNotifier, AuthTab>(
  AuthTabNotifier.new,
);

class ObscurePasswordNotifier extends Notifier<bool> {
  @override
  bool build() => true;

  void toggle() => state = !state;
  void setVisible(bool visible) => state = !visible;
}

final obscurePasswordProvider = NotifierProvider<ObscurePasswordNotifier, bool>(
  ObscurePasswordNotifier.new,
);

class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  AuthState copyWith({bool? isLoading, String? errorMessage, bool? isSuccess}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    await Future.delayed(const Duration(milliseconds: 1000));

    if (username.trim().isEmpty || password.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Please enter valid credentials',
      );
      return false;
    }

    state = state.copyWith(
      isLoading: false,
      isSuccess: true,
      errorMessage: null,
    );
    return true;
  }

  void reset() {
    state = const AuthState();
  }
}

final authControllerProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
