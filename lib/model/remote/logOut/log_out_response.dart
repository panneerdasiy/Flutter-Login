class LogOutResponse {
  String? error;

  LogOutResponse({this.error});

  bool isSuccess() {
    return error == null || error!.trim().isEmpty;
  }
}
