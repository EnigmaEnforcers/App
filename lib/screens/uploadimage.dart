import 'dart:io';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key, required this.onPickedImage});
  final void Function(File pickedImage) onPickedImage;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lighttheme.colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Upload Image"),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0,25,0,0),
              child: SizedBox(
                height: 15,
              ),
            ),
            MaterialButton(
              color: lighttheme.colorScheme.primary,
              child: const Text(
                "Pick Image from Gallery",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _getFromGallery();
              },
            ),
            MaterialButton(
              color: lighttheme.colorScheme.primary,
              child: const Text(
                "Pick Image from Camera",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _getFromCamera();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _selectedImage != null
                ? SizedBox(
                    height: 250,
                    width: 300,
                    child: Image.file(
                      _selectedImage!,
                    ),
                  )
                : const Text("Please Select an Image")
          ],
        ),
      ),
    );
  }

  Future _getFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) {
      return;
    }
    _pickImage(returnedImage);
  }

  Future _getFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('We are facing some issue.Try again later'),
        ),
      );

      return;
    }
    _pickImage(returnedImage);
  }

  void _pickImage(XFile returnedImage) {
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
    widget.onPickedImage(_selectedImage!);
  }
}
