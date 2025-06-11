import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/view/forgot_password_flow.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          child: const Text('Forgot Password?'),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const ForgotPasswordFlow(),
              ),
            );
          },
        ),
      ),
    );
  }
}
