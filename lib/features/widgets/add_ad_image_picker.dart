import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/foundation.dart';

class AddAdImagePicker extends StatefulWidget {
  final Function(Uint8List imageBytes) onImageSelected;

  const AddAdImagePicker({super.key, required this.onImageSelected});

  @override
  State<AddAdImagePicker> createState() => _AddAdImagePickerState();
}

class _AddAdImagePickerState extends State<AddAdImagePicker> {
  Uint8List? _displayedImageBytes;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Uint8List imageBytes;
      if (kIsWeb) {
        imageBytes = await pickedFile.readAsBytes();
      } else {
        imageBytes = await io.File(pickedFile.path).readAsBytes();
      }

      img.Image? decoded = img.decodeImage(imageBytes);
      if (decoded != null) {
        img.Image resized = img.copyResize(decoded, width: 600);
        imageBytes = Uint8List.fromList(img.encodeJpg(resized, quality: 70));
      }

      setState(() {
        _displayedImageBytes = imageBytes;
      });

      widget.onImageSelected(imageBytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_displayedImageBytes != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Image.memory(_displayedImageBytes!, height: 180),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_camera),
              label: const Text('الكاميرا'),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo_library),
              label: const Text('المعرض/الجهاز'),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ],
    );
  }
}
