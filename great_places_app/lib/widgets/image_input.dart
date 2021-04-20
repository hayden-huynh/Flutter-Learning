import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
      source: ImageSource
          .camera, // 'camera' to take new photo, 'gallery' to choose from existing photos
      maxWidth: 600,
    );
    if (pickedFile == null) {
      return;
    }
    final imageFile = File(pickedFile.path);

    setState(() {
      _storedImage = imageFile;
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path); // Extracting the file name
    final savedFile = await imageFile
        .copy('${appDir.path}/$fileName'); // Copy the file to the provided path
    widget.onSelectImage(savedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 220,
          height: 165,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage, fit: BoxFit.cover)
              : Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take picture'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
