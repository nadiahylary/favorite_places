import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onPickImage, }) : super(key: key);
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _takenImage = File(pickedImage.path);
    });
    widget.onPickImage(_takenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget containerChild = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(
          Icons.camera_alt,
        ),
        label: const Text("Take an Image"));

    if (_takenImage != null) {
      containerChild = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _takenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: containerChild,
    );
  }
}
