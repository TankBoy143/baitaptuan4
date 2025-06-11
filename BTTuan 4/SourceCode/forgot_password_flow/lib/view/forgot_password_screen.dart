import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/model/forgot_password_state.dart';

abstract class ForgotPasswordScreen extends StatelessWidget {
  final ForgotPasswordState state;
  final ValueChanged<ForgotPasswordState> onStateChanged;
  final VoidCallback onNext;

  const ForgotPasswordScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onNext,
  });

  @protected
  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(),
              const SizedBox(height: 24),
              buildBody(context),
              const SizedBox(height: 24),
              buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  @protected
  Widget buildHeader();

  @protected
  Widget buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: onNext,
        child: const Text('Next'),
      ),
    );
  }
}
