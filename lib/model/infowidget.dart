import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: lighttheme.colorScheme.tertiary,
    title: const Text("Help: "),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Post Complaint:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "To post a complaint of an lost child.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Found child:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "To report if found an lost child.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "List of Children found:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "To see the list of all lost children.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        )
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
