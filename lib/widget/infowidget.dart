import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(
    elevation: 70,
    backgroundColor: lighttheme.colorScheme.background,
    // title: const Text("Help: "),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Help:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Post Complaint:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          "To post a complaint of an lost child.",
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
  );
}
