import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;


class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';
  File? _enteredImage;
  PlaceLocation? _placeLocation;

  void _savePlace() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_placeLocation);
      if(_placeLocation == null || _enteredImage == null){
        return;
      }
      final appDir = await syspath.getApplicationSupportDirectory();
      final imageName = path.basename(_enteredImage!.path);
      final copiedImage = await _enteredImage!.copy('${appDir.path}/$imageName}');

      Place newPlace = Place(
          name: _enteredName,
          image: copiedImage,
          placeLocation: _placeLocation!
      );

      Navigator.of(context).pop(newPlace);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text("Name"),
                        //labelText: "Name",
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.trim().length <= 1 ||
                            value.trim().length > 50) {
                          return "Please enter a name of 2 to 50 characters long";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredName = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ImageInput(
                      onPickImage: (image) {
                        _enteredImage = image;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LocationInput(
                      onPickLocation: (location) {
                        _placeLocation = location;
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel")),
                        const SizedBox(
                          width: 35,
                        ),
                        TextButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                            },
                            child: const Text("Reset")),
                        const SizedBox(
                          width: 35,
                        ),
                        ElevatedButton(
                            onPressed: _savePlace,
                            child: const Text("Add Place")),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
