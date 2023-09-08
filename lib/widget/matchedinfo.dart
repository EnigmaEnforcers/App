import 'package:child_finder/model/matchedchildren.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

Widget buildMatchedImagePopupDialog(
    BuildContext context, index, matchedChildren) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: lighttheme.colorScheme.secondary,
    title: Text(
      matchedChildren[index].name,
      style: TextStyle(color: lighttheme.colorScheme.background),
    ),
    content: InteractiveViewer(
      maxScale: 2,
      minScale: 0.5,
      panEnabled: true,
      child: Image.network(
        matchedChildren[index].image,
        height: 300,
        width: 300,
      ),
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
            showDialog(
              context: context,
              builder: (context) =>
                  buildMatchedPopupDialog(context, index, matchedChildren),
            );
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

Widget buildMatchedPopupDialog(BuildContext context, index, matchedChildren) {
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (ctx) =>
                      buildMatchedImagePopupDialog(ctx, index, matchedChildren),
                );
              },
              child: Image.network(
                matchedChildren[index].image,
                height: 200,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child name: ${matchedChildren[index].name}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Lost Date: ${matchedChildren[index].lostdate}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child age: ${matchedChildren[index].age}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent name: ${matchedChildren[index].parentName}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent contact: ${matchedChildren[index].parentsContact}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Description: ${matchedChildren[index].description}",
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
