import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final bool hasBackArrow;
  CustomAppbar({super.key, required this.appBarTitle, required this.hasBackArrow}) : preferredSize = Size.fromHeight(kToolbarHeight);

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
            hasBackArrow ? Padding(
              padding: const EdgeInsets.only(left:15),
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_rounded, size: 40
              )),
            ) : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left:20),
              child: Text(appBarTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
}