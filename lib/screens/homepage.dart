// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:child_finder/model/homepagebutton.dart';
import 'package:child_finder/screens/allchildren.dart';
import 'package:child_finder/screens/child_found.dart';
import 'package:child_finder/screens/macthedchild.dart';
import 'package:child_finder/screens/postcomplaint.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:child_finder/widget/infowidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: lighttheme.colorScheme.background,
              title: const Text('Exit the app'),
              content: const Text('Do you want to exit Find My Child ?'),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        lighttheme.colorScheme.secondary),
                  ),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        lighttheme.colorScheme.secondary),
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: lighttheme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: lighttheme.appBarTheme.backgroundColor,
          centerTitle: true,
          title: const Text('Find My Child'),
          leading: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        buildPopupDialog(context));
              },
              icon: const Icon(Icons.help)),
          actions: [
            IconButton(
                onPressed: () async {
                  showExitPopup();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HomePageButton(
                buttonText: "Lost your child ?",
                screen: PostComplaint(),
                icon: Icons.add_box_outlined,
              ),
              const HomePageButton(
                buttonText: "Found a child ?",
                screen: ChildFound(),
                icon: Icons.add_box,
              ),
              const HomePageButton(
                buttonText: "List of all children lost",
                screen: AllChildren(),
                icon: Icons.list,
              ),
              const HomePageButton(
                buttonText: "List of all children found",
                screen: MatchedChild(),
                icon: Icons.list,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: lighttheme.colorScheme.secondary),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            lighttheme.colorScheme.secondary),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () async {
                      final Uri url = Uri(scheme: 'tel', path: "100");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        const SnackBar(
                            content: Text(
                                "Cannot call the nearest police station !"));
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_police_outlined,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 7),
                        Text("Call Police Station",
                            style:
                                TextStyle(fontSize: 20, color: Colors.amber)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
