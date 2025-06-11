import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_flow/view/splash_screen.dart';

import 'easy_time_management_page.dart';
import 'increase_effectiveness_page.dart';
import 'onboarding_page.dart';
import 'reminder_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingPage> pages = const [
    EasyTimeManagementPage(),
    IncreaseEffectivenessPage(),
    ReminderPage(),
  ];

  void _nextPage() {
    if (_currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SplashScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
        (route) => false,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToLastPage() {
    _controller.jumpToPage(pages.length - 1);
    setState(() => _currentIndex = pages.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == pages.length - 1;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Row(
          children: List.generate(pages.length, (index) {
            final isActive = index == _currentIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color:
                    isActive
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey4,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
        middle: const Text("SmartTasks"),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _skipToLastPage,
          child: const Text(
            "skip",
            style: TextStyle(color: CupertinoColors.activeBlue, fontSize: 16),
          ),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return pages[index].buildContent(context);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: CupertinoColors.systemBackground,
                child:
                    _currentIndex == 0
                        ? SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            onPressed: _nextPage,
                            borderRadius: BorderRadius.circular(28),
                            color: CupertinoColors.activeBlue,
                            child: Text(
                              isLast ? "Get Started" : "Next",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                        : Row(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _previousPage,
                                borderRadius: BorderRadius.circular(28),
                                color: CupertinoColors.activeBlue,
                                child: const Icon(
                                  CupertinoIcons.back,
                                  color: CupertinoColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: SizedBox(
                                height: 56,
                                child: CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  onPressed: _nextPage,
                                  borderRadius: BorderRadius.circular(28),
                                  color: CupertinoColors.activeBlue,
                                  child: Text(
                                    isLast ? "Get Started" : "Next",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
