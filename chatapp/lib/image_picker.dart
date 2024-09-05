import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<StatefulWidget> createState() {
    return UserImagePickerState();
  }
}

class UserImagePickerState extends State<UserImagePicker> {
  File? pickedimage;

  void pickingImage() async {
    final imagepicker = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);

    if (imagepicker == null) {
      return;
    }

    setState(() {
      pickedimage = File(imagepicker.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: pickingImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              foregroundImage:
                  pickedimage != null ? FileImage(pickedimage!) : null,
            )),
      ],
    );
  }
}
