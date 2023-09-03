import 'package:child_finder/model/lostChildern.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, index , _lostChildren) {
  return AlertDialog(
    backgroundColor: lighttheme.colorScheme.secondary,
    title: Text(
      'Child Details :',
      style: TextStyle(color: lighttheme.dialogBackgroundColor),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 200,
            width: 200,
            child: Image.network(_lostChildren[index].image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child name: ${_lostChildren[index].name}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Lost Date: ${_lostChildren[index].lostdate}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child age: ${_lostChildren[index].age}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent name: ${_lostChildren[index].parentName}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent contact: ${_lostChildren[index].parentContact}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Description: ${_lostChildren[index].description}",
            style: TextStyle(color: lighttheme.colorScheme.background),
          ),
        ),
      ],
    ),
    actions: <Widget>[
      OutlinedButton(
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
    ],
  );
}
