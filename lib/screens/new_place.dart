import 'package:flutter/material.dart';
import '../models/place.dart';

class NewPlaceScreen extends StatefulWidget {
  const NewPlaceScreen({Key? key}) : super(key: key);

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = '';


  void _savePlace() async{
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
        Place newPlace = Place(
          name: _enteredName,
        );
        Navigator.of(context).pop(
            newPlace
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Place"),
      ),
      body: Padding(
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
                    validator: (value){
                      if(value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length > 50){
                        return "Please enter a name of 2 to 50 characters long";
                      }
                      return null;
                    },
                    onSaved: (value){
                      _enteredName = value!;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel")),
                      const SizedBox(
                        width: 35,
                      ),
                      TextButton(
                          onPressed: (){
                            _formKey.currentState!.reset();
                          },
                          child: const Text("Reset")),
                      const SizedBox(
                        width: 35,
                      ),
                      ElevatedButton(
                          onPressed: _savePlace,
                          child: const Text("Add Place")
                      ),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}