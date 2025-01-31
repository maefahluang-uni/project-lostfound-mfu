import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  CustomAppbar({Key? key, required this.appBarTitle}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(),
      ),
      height: 109,
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:15),
              child: Icon(Icons.arrow_back_rounded, size: 40),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15),
              child: Text(appBarTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}