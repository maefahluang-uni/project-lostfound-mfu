import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/components/custom_dropdown.dart';
import 'package:lost_found_mfu/helpers/post_api_helper.dart';
import 'package:lost_found_mfu/ui/screens/home.dart';
import 'package:lost_found_mfu/ui/screens/post/date_time_picker_row.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _itemController = TextEditingController();
  final _itemStatusController = TextEditingController();
  final _colorController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageFileController = TextEditingController();

  List<XFile>? selectedImages;

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      setState(() {
        selectedImages = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Post", hasBackArrow: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Item',
                controller: _itemController,
                validator: (value) =>
                    value!.isEmpty ? "Name can't be empty" : null,
              ),
              const SizedBox(height: 16),
              CustomDropdown(
                controller: _itemStatusController,
                label: 'Lost/Found',
                items: ['Lost', 'Found'],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              CustomDropdown(
                controller: _colorController,
                label: 'Color',
                items: [
                  'Black',
                  'Blue',
                  'Green',
                  'Yellow',
                  'Red',
                  'Gray',
                  'Orange',
                  'Teal',
                  'White'
                ],
                onChanged: (value) {},
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Phone Number',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DateTimePickerRow(
                dateController: _dateController,
                timeController: _timeController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Location',
                controller: _locationController,
                // validator: (value) {
                //   if (value!.length > 30) {
                //     return "Location should be maximum 30 characters";
                //   } else {
                //     return "";
                //   }
                // },
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: TextStyle(
                  color: AppColor.theme.hintColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              CustomTextField(
                label: '',
                controller: _descriptionController,
                height: 120,
                // maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 16),
              selectedImages != null && selectedImages!.isNotEmpty
                  ? Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColor.theme.primaryColor.withAlpha(128)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: PageView.builder(
                        itemCount: selectedImages!.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(selectedImages![index].path),
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    )
                  : GestureDetector(
                      onTap: _pickImages,
                      child: UploadPhotoBox(),
                    ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 50,
                      width: 170,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Color(0xFFCF2D1E)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Color(0xFFCF2D1E), fontSize: 18)),
                      )),
                  CustomButton(
                    text: 'Upload Post',
                    width: 180,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await PostApiHelper.uploadPost(
                            item: _itemController.text.trim(),
                            itemStatus: _itemStatusController.text.trim(),
                            date: _dateController.text.trim(),
                            time: _timeController.text.trim(),
                            location: _locationController.text.trim(),
                            imageFile: _imageFileController.text.isNotEmpty
                                ? File(_imageFileController.text.trim())
                                : null,
                            color: _colorController.text.isNotEmpty
                                ? _colorController.text.trim()
                                : null,
                            phone: _phoneController.text.isNotEmpty
                                ? _phoneController.text.trim()
                                : null,
                            desc: _descriptionController.text.isNotEmpty
                                ? _descriptionController.text.trim()
                                : null);

                        if (response.containsKey("error")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response["error"])));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Upload Post Successfully")));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadPhotoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.theme.primaryColor.withAlpha(128)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              color: AppColor.theme.primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              'Upload Photos',
              style: TextStyle(
                color: AppColor.theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
