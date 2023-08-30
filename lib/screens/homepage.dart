// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:child_finder/screens/allchildren.dart';
import 'package:child_finder/screens/child_found.dart';
import 'package:child_finder/screens/onboardscreen.dart';
import 'package:child_finder/screens/postcomplaint.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildPopupDialog(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: lighttheme.colorScheme.tertiary,
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
          false; //if showDialouge had returned null, then return false
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
                        _buildPopupDialog(context));
              },
              icon: const Icon(Icons.help)),
          actions: [
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', false);

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const OnboardScreen()),
                  );
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: lighttheme.colorScheme.secondary),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            lighttheme.colorScheme.primary),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PostComplaint()),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Post Complaint",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: lighttheme.colorScheme.secondary),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            lighttheme.colorScheme.primary),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChildFound()),
                        );
                      },
                      child: const Text("Found child",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: lighttheme.colorScheme.secondary),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              lighttheme.colorScheme.primary),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)))),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            });
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllChildren()),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text("List of Children lost",
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    color: lighttheme.colorScheme.primary,
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
                    child: const Text("Call Nearest Police Station",
                        style: TextStyle(fontSize: 20)),
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
