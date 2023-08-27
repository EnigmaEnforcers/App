import 'package:child_finder/screens/uploadimage.dart';
import 'package:flutter/material.dart';

class ChildFound extends StatefulWidget {
  const ChildFound({super.key});

  @override
  State<ChildFound> createState() => _ChildFoundState();
}

class _ChildFoundState extends State<ChildFound> {
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(title: const Text("Post a Complain")),
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
                      labelText: "Child's Name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Child's age",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Parent's Name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Contact",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const UploadImage();
                }));
              },
              child: const Text("Upload Image"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}