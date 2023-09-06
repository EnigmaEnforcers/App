import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

class HomePageButton extends StatefulWidget {
  final String buttonText;
  final Widget screen;
  final IconData icon;
  const HomePageButton(
      {super.key,
      required this.screen,
      required this.buttonText,
      required this.icon});

  @override
  State<HomePageButton> createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              });
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.screen),
          );
          if (!mounted) return;
          Navigator.of(context).pop();
        },
        child: Container(
          height: 100,
          width: 300,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                lighttheme.colorScheme.primary,
                lighttheme.colorScheme.secondary,
                Colors.black
              ],
              radius: 2.2,
            ),
            color: lighttheme.colorScheme.primary,
            shape: BoxShape.rectangle,
            border: Border.all(color: lighttheme.colorScheme.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: lighttheme.colorScheme.background,
              ),
              const SizedBox(
                width: 7,
              ),
              Text(widget.buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: lighttheme.colorScheme.background))
            ],
          ),
        ),
      ),
    );
  }
}
