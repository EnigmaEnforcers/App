// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:child_finder/model/homepagebutton.dart';
import 'package:child_finder/screens/allchildrenlost.dart';
import 'package:child_finder/screens/child_found.dart';
import 'package:child_finder/screens/macthedchild.dart';
import 'package:child_finder/screens/postcomplaint.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:child_finder/widget/infowidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List screens = [
    const PostComplaint(),
    const ChildFound(),
    const AllChildren(),
    const MatchedChild()
  ];
  List textRequired = [
    "Lost your Child ?",
    "Found a Child ?",
    "All children Lost",
    "All children Found"
  ];
  List iconsReq = [
    Icons.add_box_outlined,
    Icons.add_box,
    Icons.list,
    Icons.list
  ];
  List colors = [
    lighttheme.colorScheme.primary,
    lighttheme.colorScheme.secondary,
    lighttheme.colorScheme.secondary,
    lighttheme.colorScheme.primary,
  ];
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
                backgroundColor:
                    MaterialStatePropertyAll(
                    lighttheme.appBarTheme.backgroundColor),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(
                    lighttheme.appBarTheme.backgroundColor),
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: lighttheme.colorScheme.background,
        appBar: AppBar(
          backgroundColor: lighttheme.appBarTheme.backgroundColor,
          centerTitle: true,
          title: const Text('Find My Kid'),
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
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 8, 20),
                child: Text(
                  'Hello! Parents ...',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 150,
                            childAspectRatio: 1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            crossAxisCount: 2),
                    itemCount: 4,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: HomePageButton(
                          color: colors[index],
                          buttonText: textRequired[index],
                          icon: iconsReq[index],
                          screen: screens[index],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 100,
                width: 300,
                child: Marquee(
                  text: '! FIND MY KID !',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                  scrollAxis: Axis.horizontal,
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 30.0,
                  velocity: 80.0,
                  accelerationCurve: Curves.bounceInOut,
                ),
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
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.brown),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final Uri url = Uri(scheme: 'tel', path: "100");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        const SnackBar(
                          content:
                              Text("Cannot call the nearest police station !"),
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.local_police_outlined,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          "Call Nearby Police Station",
                          style: TextStyle(
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                        ),
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
