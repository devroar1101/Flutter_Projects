import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImagePickerWidget extends StatefulWidget {
  ImagePickerWidget({super.key, required this.formImage});

  void Function(File selectedImage) formImage;
  @override
  State<StatefulWidget> createState() {
    return ImagePickerWidgetState();
  }
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? pickedImage;

  void pickImage() async {
    final chosenImage = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxWidth: 200, imageQuality: 50);

    if (chosenImage == null) {
      return;
    }

    setState(() {
      pickedImage = File(chosenImage.path);
    });

    widget.formImage(pickedImage!);
  }

  @override
  Widget build(context) {
    return InkWell(
      onTap: pickImage,
      child: CircleAvatar(
        radius: 50,
        child: ClipOval(
          child: pickedImage != null
              ? Image.file(
                  pickedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Icon(
                  Icons.camera,
                  size: 20,
                ),
        ),
      ),
    );
  }
}
