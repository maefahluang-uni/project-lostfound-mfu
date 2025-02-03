import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatelessWidget {
  const ImageUpload({super.key, required this.onImagePicked});

  final Function(XFile?) onImagePicked;

  Future _pickImageFromGallery() async {
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(selectedImage != null){
      onImagePicked(selectedImage);
    }
  }

  Future _takePictureFromCamera() async {
    final selectedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(selectedImage != null){
      onImagePicked(selectedImage);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(                
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text("Select your image input method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: (){_pickImageFromGallery();}, child: Text("Select from gallery", style: TextStyle(fontSize: 16))),
                        TextButton(onPressed: (){_takePictureFromCamera();}, child: Text("Take a picture", style: TextStyle(fontSize: 16)))
                      ],)
                    )
                  ); 
  }
}