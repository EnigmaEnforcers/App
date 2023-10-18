// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:child_finder/screens/map.dart';
import 'package:child_finder/screens/uploadimage.dart';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ChildFound extends StatefulWidget {
  const ChildFound({super.key});

  @override
  State<ChildFound> createState() => _ChildFoundState();
}

class _ChildFoundState extends State<ChildFound> {
  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();
  File? _selectedImage;
  var _childName = '';
  var _childAge = '';
  var _contact = '';
  var _description = '';
  var _lostdate = 'Please Select Date';
  var xCor;
  var yCor;

  void _presentdatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(2000);
    final pickedDate = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: lighttheme.colorScheme.tertiary,
              onPrimary: lighttheme.colorScheme.background,
              onSurface: lighttheme.appBarTheme.backgroundColor!,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
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
      _lostdate = DateFormat('EEE , dd-MM-yyyy').format(pickedDate!);
    });
  }

  Future uploadDetails({
    required String name,
    required String age,
    required String contact,
    required String description,
    required String imgUrl,
  }) async {
    final foundChild =
        FirebaseFirestore.instance.collection('foundChild').doc();

    final json = {
      'childName': name,
      'childAge': age,
      'findersContact': contact,
      'foundChildDescription': description,
      'imgUrl': imgUrl,
    };
    await foundChild.set(json);
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
    if (_lostdate == 'Please Select Date') {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please Select a Date'),
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
          .child('found_user_image')
          .child('${uuid.v1()}.jpg');
      await storageRef.putFile(_selectedImage!);
      final imgURL = await storageRef.getDownloadURL();

      uploadDetails(
          name: _childName,
          age: _childAge,
          contact: _contact,
          description: _description,
          imgUrl: imgURL);

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Details uploaded successfully"),
        ),
      );
    } catch (error) {
      Navigator.of(context).pop();
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
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Post Found Child Details",
        ),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
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
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(12),
                            labelText: "Child's Name",
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
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
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(12),
                            labelText: "Child's age",
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
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
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(12),
                            labelText: "Contact",
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
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
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            contentPadding: const EdgeInsets.all(12),
                            labelText: "Description",
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _lostdate,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                        ),
                        IconButton(
                          onPressed: () {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
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
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                    child: SizedBox(
                      height: 40,
                      width: 150,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: _selectedImage == null
                              ? MaterialStatePropertyAll(
                                  lighttheme.colorScheme.tertiary)
                              : const MaterialStatePropertyAll(
                                  Color(0xff38CF59),
                                ),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return UploadImage(
                              onPickedImage: (image) {
                                _selectedImage = image;
                                setState(() {});
                              },
                            );
                          }));
                        },
                        label: _selectedImage == null
                            ? Text(
                                "Upload Image",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                ),
                              )
                            : Text(
                                "Image Uploaded",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .backgroundColor),
                              ),
                        icon: _selectedImage == null
                            ? const Icon(Icons.image)
                            : const Icon(Icons.check),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStatePropertyAll(
                            lighttheme.colorScheme.tertiary),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) {
                              return const LiveLocationPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Last Seen at ?",
                        style: TextStyle(
                            fontSize: 14,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 180,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStatePropertyAll(
                        lighttheme.colorScheme.tertiary),
                  ),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _submitForm();
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
