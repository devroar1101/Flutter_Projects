import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vettigroup/config/palette.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key, required this.imagePicked});

  final Function(File) imagePicked;

  @override
  Widget build(BuildContext context) {
    File? pickedImage;

    void pickImage(String type) async {
      final imagePicker = ImagePicker();
      final selectedImage;

      if (type == 'Camera') {
        selectedImage = await imagePicker.pickImage(
            source: ImageSource.camera, maxWidth: 600, imageQuality: 70);
      } else {
        selectedImage = await imagePicker.pickImage(
            source: ImageSource.gallery, maxWidth: 600, imageQuality: 70);
      }

      if (selectedImage == null) {
        return;
      } else {
        final croppedFile =
            await ImageCropper().cropImage(sourcePath: selectedImage.path);
        pickedImage = File(croppedFile!.path);
        imagePicked(pickedImage!);
        Navigator.pop(context);
      }
    }

    return Container(
      padding: const EdgeInsets.all(40),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                pickImage('Camera');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.camera,
                    size: 50,
                    color: Palette.vettiGroupColor,
                  ),
                  const Text('Camera'),
                ],
              )),
          InkWell(
              onTap: () {
                pickImage('Gallery');
              },
              child: Column(
                children: [
                  Icon(
                    Icons.filter,
                    size: 50,
                    color: Palette.vettiGroupColor,
                  ),
                  const Text('Gallery'),
                ],
              )),
        ],
      ),
    );
  }
}
