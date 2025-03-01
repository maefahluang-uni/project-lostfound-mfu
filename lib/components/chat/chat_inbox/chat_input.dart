import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/components/common/image_upload.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key, required this.onImagePicked, required this.onSendMessage});

  final Function(XFile?) onImagePicked; 
  final Function(String) onSendMessage;

  @override 
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _ChatMessageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ✅ Message Input Field
          Expanded(
            child: TextFormField(
              controller: _ChatMessageInputController,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                filled: true,
                fillColor: AppColor.chatBackground,
                suffixIcon: IconButton(
                  onPressed: () => _pickImage(),
                  icon: const Icon(Icons.camera_alt_rounded),
                ),
                hintText: "Send a message...",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                ),
              ),
            ),
          ),

          /// ✅ Send Button
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              String messageText = _ChatMessageInputController.text.trim();
              if (messageText.isNotEmpty) {
                widget.onSendMessage(messageText);
                _ChatMessageInputController.clear(); // ✅ Clear the input field
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor.theme.primaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(Icons.send, size: 30, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ Handle Image Upload Dialog
  Future<void> _pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ImageUpload(
        onImagePicked: (XFile? image) {
          if (image != null) {
            widget.onImagePicked(image);
          }
          Navigator.pop(context); // ✅ Close the dialog after picking an image
        },
      ),
    );
  }
}
