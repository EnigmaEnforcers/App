import 'package:child_finder/model/lostChildern.dart';
import 'package:flutter/material.dart';

class AllChildrenCard extends StatefulWidget {
  final LostChildren data;
  const AllChildrenCard({super.key, required this.data});

  @override
  State<AllChildrenCard> createState() => _AllChildrenCardState();
}

class _AllChildrenCardState extends State<AllChildrenCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 2)),
        child: Row(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.data.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
