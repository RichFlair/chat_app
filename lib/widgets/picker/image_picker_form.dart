import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerForm extends StatefulWidget {
  final void Function(File selectedImage) onImagePicked;
  const ImagePickerForm({
    super.key,
    required this.onImagePicked,
  });

  @override
  State<ImagePickerForm> createState() => _ImagePickerFormState();
}

class _ImagePickerFormState extends State<ImagePickerForm> {
  File? _pickedImage;

  void _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    final imageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = imageFile;
    });
    widget.onImagePicked(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.camera_alt_outlined),
          label: const Text('Add image'),
        ),
      ],
    );
  }
}
