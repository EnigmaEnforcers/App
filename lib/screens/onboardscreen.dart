// ignore_for_file: use_build_context_synchronously

import 'package:child_finder/screens/homepage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final controller = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
    required String hashtag,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 64,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: lighttheme.colorScheme.background,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: lighttheme.colorScheme.background,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                hashtag,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: lighttheme.colorScheme.background,
                ),
              ),
            )
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.primary,
      body: Container(
        padding: const EdgeInsets.only(bottom: 70),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() => isLastPage = index == 2);
          },
          children: [
            buildPage(
              color: lighttheme.colorScheme.primary,
              urlImage: 'assets/onboard1.png',
              title: 'Post a Complaint',
              subtitle: "Together, we can bring them home.\nPost your child's details in the\n'Lost Your Child ?' section.",
              hashtag: '#HelpFindOurChildren'
            ),
            buildPage(
              color: lighttheme.colorScheme.primary,
              urlImage: 'assets/onboard2.png',
              title: "Reunite, Found a Lost Child !",
              subtitle: "Let's bring them back to safety together.",
              hashtag: '#HelpFindOurChildren',
            ),
            buildPage(
              color: lighttheme.colorScheme.primary,
              urlImage: 'assets/onboard3.png',
              title: 'All Reunited Children',
              subtitle: 'An extensive list of all reunited children till date.',
              hashtag: '#HelpFindOurChildren'
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  minimumSize: const Size.fromHeight(70),
                  backgroundColor: lighttheme.colorScheme.primary),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);
                Navigator.of(context).pushReplacement(
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 250),
                      reverseDuration: const Duration(milliseconds: 250),
                      child: const HomePage()),
                );
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                    fontSize: 24, color: lighttheme.colorScheme.background),
              ),
            )
          : Container(
              color: lighttheme.colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(2),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 15,
                          color: lighttheme.colorScheme.background),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 14,
                        dotColor: lighttheme.colorScheme.background,
                        activeDotColor: Colors.amber,
                      ),
                      onDotClicked: (index) => controller.animateToPage(index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                    child: Text("Next",
                        style: TextStyle(
                            fontSize: 15,
                            color: lighttheme.colorScheme.background)),
                  ),
                ],
              ),
            ),
    );
  }
}
