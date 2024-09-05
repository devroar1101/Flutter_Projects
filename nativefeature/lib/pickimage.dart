import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class PickImageWidget extends StatefulWidget {
  PickImageWidget({super.key, required this.addImage});

  void Function(File image) addImage;

  @override
  State<StatefulWidget> createState() {
    return PickImageWidgetState();
  }
}

class PickImageWidgetState extends State<PickImageWidget> {
  File? pickedImage;
  void selectImage() async {
    final imagePicker = ImagePicker();
    final selectedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (selectedImage == null) {
      return;
    }
    setState(() {
      pickedImage = File(selectedImage.path);
    });
    widget.addImage(pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: TextButton.icon(
        onPressed: selectImage,
        label: const Text('pick image'),
        icon: const Icon(Icons.camera),
      ),
    );

    if (pickedImage != null) {
      content = Image.file(
        pickedImage!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    return Container(
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
      child: content,
    );
  }
}
