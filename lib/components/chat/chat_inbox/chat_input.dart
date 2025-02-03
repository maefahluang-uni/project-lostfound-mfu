import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_found_mfu/components/common/image_upload.dart';
import 'package:lost_found_mfu/ui/theme/app_color.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key, required this.onImagePicked});
  final Function(XFile?) onImagePicked; 
  @override 
  State<ChatInput> createState(){
    return _ChatInputState();
  }
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _ChatMessageInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 19),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width:300,
            child: Expanded(
              child: TextFormField(
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                controller: _ChatMessageInputController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  filled: true,
                  fillColor: AppColor.chatBackground,
                  suffixIcon: IconButton(onPressed: () => 
                  showDialog(context: context, builder: (BuildContext context) => ImageUpload(onImagePicked: widget.onImagePicked)), 
                  icon: Icon(Icons.camera_alt_rounded)),
                  hintText: "Send a message...",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(100))
                  )
                ),
              ),
            ),
          ),
        Container(
          alignment: Alignment.center,
          width:50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColor.theme.primaryColor,
            borderRadius: BorderRadius.circular(100)
          ),
          child: Icon(Icons.send, size: 30, color: Colors.white)
        )
      ],)
    );
  }
}

