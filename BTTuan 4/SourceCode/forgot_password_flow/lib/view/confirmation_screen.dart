import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/view/forgot_password_screen.dart';

class ConfirmationScreen extends ForgotPasswordScreen {
  const ConfirmationScreen({
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
        const Text(
          'Confirm',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'We are here to help you!',
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
        _buildInfoRow('Email', state.email),
        const SizedBox(height: 16),
        _buildInfoRow('Verification Code', state.verificationCode),
        const SizedBox(height: 16),
        _buildInfoRow('Password', '••••••••'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        const Icon(
          CupertinoIcons.check_mark_circled_solid,
          color: CupertinoColors.activeGreen,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: CupertinoColors.secondaryLabel),
            ),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  @override
  Widget buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: onNext,
        child: const Text('Complete'),
      ),
    );
  }
}
