import 'dart:convert';
import 'dart:io';

import 'package:child_finder/screens/uploadimage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
// import 'package:child_finder/widgets/image_input.dart';

final uuid = Uuid();

class PostComplaint extends StatefulWidget {
  const PostComplaint({super.key});

  @override
  State<PostComplaint> createState() => _PostComplaintState();
}

class _PostComplaintState extends State<PostComplaint> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  var _childName = '';
  var _childAge = '';
  var _parentName = '';
  var _contact = '';
  var _description = '';
  //  File
  // File
  void _submitForm() async {
    var validation = _formKey.currentState!.validate();
    if (!validation || _selectedImage == null) return;
    _formKey.currentState!.save();

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('lost_user_image')
          .child('${uuid.v1()}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imgURL = await storageRef.getDownloadURL();
      print(imgURL);
      final url =
          Uri.https('accenture-578fc-default-rtdb.firebaseio.com', 'lost.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _childName,
            'age': _childAge,
            'parent_name': _parentName,
            'parent_contact': _contact,
            'image': imgURL,
            'description': _description,
          },
        ),
      );

      print(response.body);
    } catch (error) {
      print(error);
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Post a Complain",
        ),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Child's Name",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please ente a valid name';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _childName = v!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Child's age",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          (int.tryParse(value) ?? 0) == 0) {
                        return 'Please ente a valid age';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _childAge = v!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Parent's Name",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please ente a valid name';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _parentName = v!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Contact",
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().length != 10) {
                        return 'Please ente a valid number';
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _contact = v!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: "Description",
                    ),
                    onSaved: (v) {
                      _description = v!;
                    },
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
                      onPickedImage: (image) {
                        _selectedImage = image;
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
              onPressed: _submitForm,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
