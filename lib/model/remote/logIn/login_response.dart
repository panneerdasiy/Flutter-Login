class LoginResponse {
  final String? token;
  final String? error;

  const LoginResponse({
    this.token,
    this.error,
  });

  bool isSuccess() {
    return token?.trim().isNotEmpty == true;
  }
}
