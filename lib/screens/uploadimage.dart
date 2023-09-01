import 'dart:io';
import 'package:child_finder/themes/lighttheme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

//TODO ----> SUBMIT BUTTON
//TODO ----> LOADING

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
        title: const Text(
          "Upload Image",
        ),
        backgroundColor: lighttheme.appBarTheme.backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: SizedBox(
                height: 15,
              ),
            ),
            MaterialButton(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              color: lighttheme.colorScheme.primary,
              child: const Text(
                "Pick Image from Gallery",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                _getFromGallery();
              },
            ),
            MaterialButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              color: lighttheme.colorScheme.primary,
              child: const Text(
                "Pick Image from Camera",
                style: TextStyle(
                  fontSize: 18,
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
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: lighttheme.colorScheme.primary,
                ),
              ),
              height: 250,
              width: 300,
              alignment: Alignment.center,
              child: _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      fit: BoxFit.contain
                      // width: 800,
                    )
                  : const Text(
                      "Please Select an Image",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
            ),
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

  void _pickImage(XFile returnedImage) async {
    try {
      var compressedImage = await FlutterImageCompress.compressAndGetFile(
          returnedImage.path, '${returnedImage.path}compressed.jpg',
          quality: 60);
      setState(
        () {
          _selectedImage = File(compressedImage!.path);
        },
      );
      widget.onPickedImage(_selectedImage!);
    } catch (e) {
      print(e);
    }
  }
}
