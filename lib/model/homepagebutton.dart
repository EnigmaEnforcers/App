import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

class HomePageButton extends StatefulWidget {
  final String buttonText;
  final Widget screen;
  final IconData icon;
  const HomePageButton(
      {super.key, required this.screen, required this.buttonText, required this.icon});

  @override
  State<HomePageButton> createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                border: Border.all(color: lighttheme.colorScheme.secondary),
                borderRadius: BorderRadius.circular(15)),
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(lighttheme.colorScheme.primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)))),
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(child: CircularProgressIndicator());
                  });
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => widget.screen),
              );
              Navigator.of(context).pop();
            },
            label:
                Text(widget.buttonText, style: const TextStyle(fontSize: 20)),
            icon: Icon(widget.icon),
          ),
        ],
      ),
    );
  }
}
