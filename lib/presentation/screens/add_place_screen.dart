import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_map_api/presentation/bloc/places_list_cubit.dart';
import 'package:google_map_api/widgets/image_input.dart';
import 'package:google_map_api/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();

  static Widget withCubit() => BlocProvider(
        create: (context) => PlacesListCubit(
          context.read(),
        ),
        child: const AddPlaceScreen(),
      );
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  double? thisLat;
  double? thisLong;
  String? adress;
  late final PlacesListCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<PlacesListCubit>(context);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Add a new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
              const SizedBox(height: 16),
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 16),
              LocationInput(
                locationCallback: (lat, long) {
                  thisLat = lat;
                  thisLong = long;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  if (_titleController.text.isEmpty) {
                    showMessage('Enter title');
                  } else if (_selectedImage == null) {
                    showMessage('Take a picture');
                  } else if (thisLat == null && thisLong == null) {
                    showMessage('Choose location');
                  } else {
                    _cubit
                        .addPlace(
                      _titleController.text,
                      _selectedImage!,
                      thisLat!,
                      thisLong!,
                    )
                        .then((value) {
                      Navigator.of(context).pop(true);
                    });
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 20,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
