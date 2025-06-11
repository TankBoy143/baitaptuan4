import 'package:flutter/cupertino.dart';

import 'onboarding_page.dart';

class IncreaseEffectivenessPage extends OnboardingPage {
  const IncreaseEffectivenessPage({super.key})
    : super(
        title: "Increase Work Effectiveness",
        description:
            "Time management and the determination of more important tasks...",
        imagePath: "assets/images/effectiveness.svg",
      );

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
