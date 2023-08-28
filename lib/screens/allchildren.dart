import 'dart:convert';

import 'package:child_finder/model/lostChildern.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//TODO ----> Handle NULL value
//TODO ---> SNACKBARS 
//TODO ---> LOADING SCREEN
//TODO ---> UI
class AllChildren extends StatefulWidget {
  const AllChildren({super.key});

  @override
  State<AllChildren> createState() => _AllChildrenState();
}

class _AllChildrenState extends State<AllChildren> {
  List<LostChildren> _lostChildren = [];

  @override
  void initState() {
    super.initState();
    _loadChilds();
  }

  void _loadChilds() async {
    final url =
        Uri.https('accenture-578fc-default-rtdb.firebaseio.com', 'lost.json');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(
          () {
            // _error = 'Failed to fetch data. Please try again later.';
          },
        );
      }

      final Map<String, dynamic> childList = json.decode(response.body);

      final List<LostChildren> loadedItem = [];
      for (final item in childList.entries) {
        loadedItem.add(
          LostChildren(
            name: item.value['name'],
            age: item.value['age'],
            parentName: item.value['parent_name'],
            parentContact: item.value['parent_contact'],
            description: item.value['description'],
            image: item.value['image'],
          ),
        );
      }

      setState(() {
        _lostChildren = loadedItem;
      });
    } catch (e) {
      //TODO
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("List of all children lost"),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: _lostChildren.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: lighttheme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: Column(
                  children: [
                    Image.network(
                      _lostChildren[index].image,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      _lostChildren[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
