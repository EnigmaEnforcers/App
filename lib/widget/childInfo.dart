import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, index, lostChildren) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: lighttheme.colorScheme.secondary,
    title: Text(
      'Child Details :',
      style: TextStyle(color: lighttheme.colorScheme.background),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 3,
              panEnabled: false,
              child: Image.network(
                lostChildren[index].image,
                height: 250,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child name: ${lostChildren[index].name}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Lost Date: ${lostChildren[index].lostdate}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child age: ${lostChildren[index].age}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent name: ${lostChildren[index].parentName}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent contact: ${lostChildren[index].parentContact}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Description: ${lostChildren[index].description}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(lighttheme.colorScheme.background)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Close',
            style: TextStyle(color: lighttheme.appBarTheme.backgroundColor),
          ),
        ),
      ),
    ],
  );
}
