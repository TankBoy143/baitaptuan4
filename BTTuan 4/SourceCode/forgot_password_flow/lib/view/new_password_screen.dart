import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/view/app_text_field.dart';
import 'package:forgot_password_flow/view/forgot_password_screen.dart';

class NewPasswordScreen extends ForgotPasswordScreen {
  const NewPasswordScreen({
    super.key,
    required super.state,
    required super.onStateChanged,
    required super.onNext,
  });

  @override
  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/uth_logo.png', width: 100, height: 100),
        const SizedBox(height: 8),
        Text(
          'Create new password',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Your new password must be different form previously used password',
          style: TextStyle(color: CupertinoColors.secondaryLabel),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          placeholder: 'Password',
          prefixIcon: CupertinoIcons.lock,
          obscureText: true,
          value: state.newPassword,
          onChanged:
              (value) => onStateChanged(state.copyWith(newPassword: value)),
        ),
        const SizedBox(height: 16),
        AppTextField(
          placeholder: 'Confirm Password',
          prefixIcon: CupertinoIcons.lock,
          obscureText: true,
          value: state.confirmPassword,
          onChanged:
              (value) => onStateChanged(state.copyWith(confirmPassword: value)),
        ),
      ],
    );
  }
}
