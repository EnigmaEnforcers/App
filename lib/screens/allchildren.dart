import 'dart:convert';
import 'package:child_finder/model/lostChildern.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  Widget _buildPopupDialog(BuildContext context, index) {
    return AlertDialog(
      backgroundColor: lighttheme.colorScheme.secondary,
      title: Text(
        'Child Details :',
        style: TextStyle(color: lighttheme.dialogBackgroundColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.network(_lostChildren[index].image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Child name: ${_lostChildren[index].name}",
              style: TextStyle(color: lighttheme.colorScheme.background),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Child age: ${_lostChildren[index].age}",
              style: TextStyle(color: lighttheme.colorScheme.background),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Parent name: ${_lostChildren[index].parentName}",
              style: TextStyle(color: lighttheme.colorScheme.background),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Description: ${_lostChildren[index].description}",
              style: TextStyle(color: lighttheme.colorScheme.background),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        OutlinedButton(
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
      ],
    );
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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 30,
            ),
            itemCount: _lostChildren.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context, index));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: lighttheme.colorScheme.secondary,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      _lostChildren[index].image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: lighttheme.dialogBackgroundColor,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
