import 'package:child_finder/screens/uploadimage.dart';
import 'package:flutter/material.dart';

class PostComplain extends StatefulWidget {
  const PostComplain({super.key});

  @override
  State<PostComplain> createState() => _PostComplainState();
}

class _PostComplainState extends State<PostComplain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Post a Complain")),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadImage()),
                  );
                },
                child: const Text("Upload Image"))
          ]),
    );
  }
}
