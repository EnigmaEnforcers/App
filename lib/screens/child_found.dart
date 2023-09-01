import 'dart:io';

import 'package:child_finder/screens/uploadimage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';

class ChildFound extends StatefulWidget {
  const ChildFound({super.key});

  @override
  State<ChildFound> createState() => _ChildFoundState();
}

class _ChildFoundState extends State<ChildFound> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.background, 
      appBar: AppBar(
        title: const Text("Found Child"),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: const Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Child's Name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Child's age",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Your Name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Your Contact",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(lighttheme.colorScheme.primary),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return UploadImage(
                      onPickedImage: (img) {
                        _selectedImage = img;
                      },
                    );
                  }));
                },
                child: const Text("Upload Image"),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(lighttheme.colorScheme.primary),
              ),
              onPressed: () {},
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
