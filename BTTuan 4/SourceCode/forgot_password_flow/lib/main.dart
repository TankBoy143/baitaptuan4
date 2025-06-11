import 'package:flutter/cupertino.dart';
import 'package:forgot_password_flow/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(home: HomePage());
  }
}
