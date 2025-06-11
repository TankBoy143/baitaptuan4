import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/view/app_text_field.dart';
import 'package:forgot_password_flow/view/forgot_password_screen.dart';

class EmailScreen extends ForgotPasswordScreen {
  const EmailScreen({
    super.key,
    required super.state,
    required super.onStateChanged,
    required super.onNext,
  });

  @override
  Widget buildBody(BuildContext context) {
    return AppTextField(
      placeholder: 'Your Email',
      prefixIcon: CupertinoIcons.mail,
      keyboardType: TextInputType.emailAddress,
      value: state.email,
      onChanged: (value) => onStateChanged(state.copyWith(email: value)),
    );
  }

  @override
  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/uth_logo.png', width: 100, height: 100),
        const SizedBox(height: 8),
        const Text(
          'Forget Password?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your Email, we will send you a verification code.',
          style: TextStyle(color: CupertinoColors.secondaryLabel),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
