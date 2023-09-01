// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:child_finder/screens/uploadimage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
// import 'package:child_finder/widgets/image_input.dart';

// TODO  ---> Error Handling
// TODO  ---> LOADING THINGS

const uuid = Uuid();

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
  var _lostdate = '';
  DateTime date = DateTime(2023, 1, 1);

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
      // print(imgURL);
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
            'date': _lostdate,
          },
        ),
      );
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complaint regsitered successfully")));
    } catch (error) {
      // print(error);
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
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Child's Name",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _childName = v!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Child's age",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            (int.tryParse(value) ?? 0) == 0) {
                          return 'Please enter a valid age';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _childAge = v!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Parent's Name",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _parentName = v!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Contact",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().length != 10) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _contact = v!;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(12),
                        labelText: "Description",
                      ),
                      onSaved: (v) {
                        _description = v!;
                      },
                    ),
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              lighttheme.dialogBackgroundColor),
                          fixedSize: const MaterialStatePropertyAll(
                              Size.fromWidth(150))),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2030),
                          
                        );
                        if (newDate == null) {
                          return;
                        }
                        setState(() {
                          date = newDate;
                          _lostdate =
                              '${date.day} - ${date.month} - ${date.year}';
                        });
                      },
                      child: (date == DateTime(2023, 1, 1))
                          ? const Text(
                              "Select Date",
                              style: TextStyle(color: Colors.black),
                            )
                          : Text(
                              _lostdate,
                              style: const TextStyle(color: Colors.black),
                            ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 10),
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(child: CircularProgressIndicator());
                    });
                _submitForm();
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
