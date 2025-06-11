import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/model/forgot_password_state.dart';
import 'package:forgot_password_flow/view/confirmation_screen.dart';
import 'package:forgot_password_flow/view/email_screen.dart';
import 'package:forgot_password_flow/view/new_password_screen.dart';
import 'package:forgot_password_flow/view/verification_code_screen.dart';

class ForgotPasswordFlow extends StatefulWidget {
  const ForgotPasswordFlow({super.key});

  @override
  State<ForgotPasswordFlow> createState() => _ForgotPasswordFlowState();
}

class _ForgotPasswordFlowState extends State<ForgotPasswordFlow> {
  var _state = ForgotPasswordState();
  int _currentStep = 0;

  void _updateState(ForgotPasswordState newState) {
    setState(() {
      _state = newState;
    });
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < 3) {
        _currentStep++;
      }
    });
  }

  void _completeFlow() {
    Navigator.pop(context);
    showCupertinoDialog(
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: const Text('Password Reset'),
            content: const Text('Your password has been successfully reset.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  Widget _buildStepScreen() {
    switch (_currentStep) {
      case 0:
        return EmailScreen(
          state: _state,
          onStateChanged: _updateState,
          onNext: _nextStep,
        );
      case 1:
        return VerificationCodeScreen(
          state: _state,
          onStateChanged: _updateState,
          onNext: _nextStep,
        );
      case 2:
        return NewPasswordScreen(
          state: _state,
          onStateChanged: _updateState,
          onNext: _nextStep,
        );
      case 3:
        return ConfirmationScreen(
          state: _state,
          onStateChanged: _updateState,
          onNext: _completeFlow,
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildStepScreen();
  }
}
