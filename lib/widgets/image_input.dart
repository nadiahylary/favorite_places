import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  void _takePicture(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3)
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton.icon(
          onPressed: _takePicture,
          icon: const Icon(
            Icons.camera_alt,
          ),
          label: const Text(
            "Choose an Image"
          )
      ),
    );
  }
}
