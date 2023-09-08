import 'package:child_finder/screens/onboardscreen.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(
    elevation: 70,
    backgroundColor: lighttheme.colorScheme.background,
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HELP',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Post Complaint:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "To post a complaint of a lost child.",
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Found child:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "To report if found an lost child.",
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "List of Children found:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "To see the list of all lost children.",
        ),
      ],
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(lighttheme.colorScheme.secondary)),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);
              if (!context.mounted) {
                return;
              }
              Navigator.of(context).pushReplacement(
                PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 250),
                    reverseDuration: const Duration(milliseconds: 250),
                    child: const OnboardScreen()),
              );
            },
            child: const Text('Tutorial'),
          ),
          OutlinedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(lighttheme.colorScheme.secondary)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )
    ],
  );
}
