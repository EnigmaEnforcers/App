// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:child_finder/screens/uploadimage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PostComplaint extends StatefulWidget {
  const PostComplaint({super.key});

  @override
  State<PostComplaint> createState() => _PostComplaintState();
}

class _PostComplaintState extends State<PostComplaint> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  File? _selectedImage;
  var _childName = '';
  var _childAge = '';
  var _parentName = '';
  var _contact = '';
  var _description = '';
  var _lostdate = 'Please Select Date';

  void _presentdatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  lighttheme.colorScheme.primary, // header background color
              onPrimary: lighttheme.colorScheme.background, // header text color
              onSurface:
                  lighttheme.appBarTheme.backgroundColor!, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor:
                    lighttheme.colorScheme.secondary, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _lostdate = DateFormat.yMd().format(pickedDate!);
    });
  }

  Future uploadLostChild({
    required String name,
    required String age,
    required String contact,
    required String description,
    required String imgUrl,
    required String parentname,
    required String lostDate,
  }) async {
    final lostChild = FirebaseFirestore.instance.collection('lostChild').doc();

    final json = {
      'childName': name,
      'childAge': age,
      'parentsContact': contact,
      'lostChildDescription': description,
      'imgUrl': imgUrl,
      'parentName': parentname,
      'lostDate': lostDate,
    };
    await lostChild.set(json);
  }

  void _submitForm() async {
    var validation = _formKey.currentState!.validate();
    if (!validation) return;
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Upload an Image'),
        ),
      );
      return;
    }
    _formKey.currentState!.save();
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('lost_user_image')
          .child('${uuid.v1()}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imgURL = await storageRef.getDownloadURL();

      uploadLostChild(
          name: _childName,
          age: _childAge,
          contact: _contact,
          description: _description,
          imgUrl: imgURL,
          parentname: _parentName,
          lostDate: _lostdate);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complaint registered successfully")));
    } catch (error) {
      Navigator.of(context).pop();
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
                            (int.tryParse(value) ?? 26) > 25 ||
                            (int.tryParse(value) ?? 0) <= 0) {
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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a relevant description';
                        }
                        return null;
                      },
                      onSaved: (v) {
                        _description = v!;
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_lostdate),
                      IconButton(
                        onPressed: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          _presentdatePicker();
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 10),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(lighttheme.colorScheme.primary),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return UploadImage(
                      onPickedImage: (image) {
                        _selectedImage = image;
                        setState(() {});
                      },
                    );
                  }));
                },
                label: _selectedImage == null
                    ? const Text("Upload Image")
                    : const Text("Image Uploaded"),
                icon: _selectedImage == null
                    ? const Icon(Icons.image)
                    : const Icon(Icons.check),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(lighttheme.colorScheme.primary),
              ),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
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
