import 'package:flutter/cupertino.dart';

import 'onboarding_page.dart';

class ReminderPage extends OnboardingPage {
  const ReminderPage({super.key})
    : super(
        title: "Reminder Notification",
        description:
            "The advantage of this application is that it also provides reminders...",
        imagePath: "assets/images/reminder.svg",
      );

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
