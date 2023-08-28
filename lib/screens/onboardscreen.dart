import 'package:child_finder/screens/homepage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
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
                style: TextStyle(
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
              urlImage: 'assets/icon.png',
              title: 'Post Complain',
              subtitle: 'To post a complaint of an lost child.',
            ),
            buildPage(
              color: lighttheme.colorScheme.primary,
              urlImage: 'assets/icon.png',
              title: 'Found child',
              subtitle: 'To report if found an lost child.',
            ),
            buildPage(
              color: lighttheme.colorScheme.primary,
              urlImage: 'assets/icon.png',
              title: 'All lost children',
              subtitle: 'List of all lost children till date.',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style:
                  TextButton.styleFrom(minimumSize: const Size.fromHeight(70)),
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', true);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                    fontSize: 24,
                    color: lighttheme.appBarTheme.backgroundColor),
              ))
          : Container(
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
                          color: lighttheme.appBarTheme.backgroundColor),
                    ),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 14,
                        dotColor: Colors.cyan,
                        activeDotColor: lighttheme.colorScheme.secondary,
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
                            color: lighttheme.appBarTheme.backgroundColor)),
                  ),
                ],
              ),
            ),
    );
  }
}