import 'package:flutter/material.dart';
import 'package:dsw52703/utils/colors.dart';

Widget backButton(BuildContext context) {
  return Align(
    alignment: Alignment.topLeft,
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
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
            style: TextStyle(color: MyColors.purpleColor, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}