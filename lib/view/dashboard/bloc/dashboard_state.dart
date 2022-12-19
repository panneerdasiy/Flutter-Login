class DashboardState {
  final bool isLoggedOut;
  final String error;

  const DashboardState({
    this.isLoggedOut = false,
    this.error = "",
  });

  DashboardState copyWith({
    bool? isLoggedOut,
    String? error,
  }) {
    return DashboardState(
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
      error: error ?? this.error,
    );
  }
}
