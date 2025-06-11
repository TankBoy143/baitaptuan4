class ForgotPasswordState {
  final String email;
  final String verificationCode;
  final String newPassword;
  final String confirmPassword;

  ForgotPasswordState({
    this.email = '',
    this.verificationCode = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  ForgotPasswordState copyWith({
    String? email,
    String? verificationCode,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      verificationCode: verificationCode ?? this.verificationCode,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
