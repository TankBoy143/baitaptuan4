import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/view/forgot_password_screen.dart';
import 'package:forgot_password_flow/view/verification_code_field.dart';

class VerificationCodeScreen extends ForgotPasswordScreen {
  const VerificationCodeScreen({
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
          'Verify Code',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Enter the file code we just sent you on your registered Email',
          style: TextStyle(color: CupertinoColors.secondaryLabel),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return VerificationCodeField(
      onChanged:
          (value) => onStateChanged(state.copyWith(verificationCode: value)),
    );
  }
}
