import 'package:flutter/cupertino.dart';

import 'onboarding_page.dart';

class EasyTimeManagementPage extends OnboardingPage {
  const EasyTimeManagementPage({super.key})
    : super(
        title: "Easy Time Management",
        description:
            "With management based on priority and daily tasks, it will give you convenience...",
        imagePath: "assets/images/time_management.svg",
      );

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
