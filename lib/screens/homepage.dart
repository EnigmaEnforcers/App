import 'package:child_finder/screens/allchildren.dart';
import 'package:child_finder/screens/child_found.dart';
import 'package:child_finder/screens/onboardscreen.dart';
import 'package:child_finder/screens/postcomplaint.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: lighttheme.dialogBackgroundColor,
      title: const Text('Help'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child:
                Text("Post Complaint: To post a complaint of an lost child."),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Found child: To report if found an lost child."),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "List of Children found: To see the list of all lost children."),
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: lighttheme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: lighttheme.appBarTheme.backgroundColor,
          centerTitle: true,
          title: const Text('Find My Child'),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context));
                },
                icon: const Icon(Icons.help)),
            IconButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setBool('showHome', false);
                  
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const OnboardScreen()),
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
                child: ElevatedButton(
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
                          builder: (context) => const PostComplaint()),
                    );
                  },
                  child: const Text(
                    "Post Complaint",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
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
                  child:
                      const Text("Found child", style: TextStyle(fontSize: 20)),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          lighttheme.colorScheme.primary),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllChildren()),
                    );
                  },
                  child: const Text("List of Children found",
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
