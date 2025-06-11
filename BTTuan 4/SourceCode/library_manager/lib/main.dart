import 'package:flutter/cupertino.dart';
import 'package:library_manager/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(home: HomeScreen());
  }
}
