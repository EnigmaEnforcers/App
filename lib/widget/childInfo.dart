// ignore_for_file: file_names

import 'package:child_finder/screens/delete_screen.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:widget_zoom/widget_zoom.dart';


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
            child: WidgetZoom(
              maxScaleFullscreen: 5,
              fullScreenDoubleTapZoomScale: 2.5,
              heroAnimationTag: 'tag',
              zoomWidget: Image.network(
                lostChildren[index].image,
                height: 200,
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
          onPressed: () async {
            // String verificationid = '';
            // await FirebaseAuth.instance.verifyPhoneNumber(
            //   phoneNumber: '+91 ${lostChildren[index].parentContact}',
            //   verificationCompleted: (PhoneAuthCredential credential) {},
            //   verificationFailed: (FirebaseAuthException e) {},
            //   codeSent: (String verificationId, int? resendToken) {
            //     verificationid = verificationId;
            //     ScaffoldMessenger.of(context).clearSnackBars();
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text(
            //           'OTP has been sent',
            //         ),
            //       ),
            //     );
            //   },
            //   codeAutoRetrievalTimeout: (String verificationId) {},
            // );
            // if (!context.mounted) return;
            final isExit = await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 250),
                reverseDuration: const Duration(milliseconds: 250),
                child: DeleteScreen(
                  childToDelete: lostChildren[index],
                  // verificationId: verificationid,
                ),
              ),
            );
            if (isExit && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Delete',
            style: TextStyle(color: lighttheme.appBarTheme.backgroundColor),
          ),
        ),
      ),
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
