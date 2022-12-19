class LoginState {
  final String email;
  final String password;
  final String error;
  final bool loggedIn;

  const LoginState({
    this.email = "",
    this.password = "",
    this.error = "",
    this.loggedIn = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? error,
    bool? loggedIn,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      error: error ?? this.error,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }
}
