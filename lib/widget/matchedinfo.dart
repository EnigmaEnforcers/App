import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:widget_zoom/widget_zoom.dart';

Widget buildMatchedPopupDialog(BuildContext context, index, matchedChildren) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    backgroundColor: lighttheme.colorScheme.background,
    title: Text(
      'Child Details :',
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: WidgetZoom(
              maxScaleFullscreen: 5,
              fullScreenDoubleTapZoomScale: 2.5,
              heroAnimationTag: 'tag',
              zoomWidget: Image.network(
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
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Lost Date: ${matchedChildren[index].lostdate}",
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Child age: ${matchedChildren[index].age}",
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent name: ${matchedChildren[index].parentName}",
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Parent contact: ${matchedChildren[index].parentsContact}",
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Description: ${matchedChildren[index].description}",
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),
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
                MaterialStatePropertyAll(lighttheme.colorScheme.background),
          ),
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
