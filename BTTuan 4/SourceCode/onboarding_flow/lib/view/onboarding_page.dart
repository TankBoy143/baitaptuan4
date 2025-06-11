import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

abstract class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context);

  Widget buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        SvgPicture.asset(imagePath, height: 200),
        const SizedBox(height: 30),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
