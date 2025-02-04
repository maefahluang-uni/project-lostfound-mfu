import 'package:flutter/material.dart';
import 'package:lost_found_mfu/components/common/custom_appbar.dart';
import 'package:lost_found_mfu/components/custom_button.dart';
import 'package:lost_found_mfu/components/custom_text_field.dart';
import 'package:lost_found_mfu/ui/screens/post/gallery_screen.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final _itemController = TextEditingController();
  final _lostFoundController = TextEditingController();
  final _colorController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(appBarTitle: "Post", hasBackArrow: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              label: 'Item',
              controller: _itemController,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Show Lost/Found options
              },
              child: CustomTextField(
                label: 'Lost/Found',
                controller: _lostFoundController,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Show color options
              },
              child: CustomTextField(
                label: 'Color',
                controller: _colorController,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Phone Number',
              controller: _phoneController,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: 'Date',
                    controller: _dateController,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    label: 'Time',
                    controller: _timeController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Location',
              controller: _locationController,
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
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GalleryScreen(),
                  ),
                );
              },
              child: UploadPhotoBox(),
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: 'Upload Post',
              width: 400,
              onPressed: () {
                // Handle post upload
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UploadPhotoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
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
