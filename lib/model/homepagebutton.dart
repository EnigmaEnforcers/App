import 'dart:math';

import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class HomePageButton extends StatefulWidget {
  final String buttonText;
  final Widget screen;
  final IconData icon;
  final Color color;
  const HomePageButton(
      {super.key,
      required this.screen,
      required this.buttonText,
      required this.icon,
      required this.color});

  @override
  State<HomePageButton> createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 250),
                reverseDuration: const Duration(milliseconds: 250),
                child: widget.screen),
          );
        },
        child: Container(
          height: 175,
          width: 175,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).appBarTheme.backgroundColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
