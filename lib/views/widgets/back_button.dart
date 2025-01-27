import 'package:flutter/material.dart';
import 'package:dsw52703/utils/colors.dart';

Widget backButton(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,

    child: Row(
      // spacing: -15,
      children: [
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 38,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            'Back',
            style: TextStyle(color: MyColors.purpleColor, fontSize: 12, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ),
  );
}