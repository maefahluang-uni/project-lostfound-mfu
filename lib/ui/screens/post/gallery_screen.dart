import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/ui/screens/post/upload_post.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImage = [];

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _selectedImage = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Gallery',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CustomButton(
                text: 'Next',
                width: 100,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadPostScreen()));
                }),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: _selectedImage.isEmpty
                  ? const Center(
                      child: Text('No image selected'),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(2),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2),
                      itemCount: _selectedImage.length,
                      itemBuilder: (context, index) {
                        return Image.file(
                          _selectedImage[index],
                          fit: BoxFit.cover,
                        );
                      })),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomButton(
              text: 'Pick Images',
              onPressed: _pickImages,
              width: 150,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
