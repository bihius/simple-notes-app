import 'package:flutter/material.dart';
import 'package:dsw52703/utils/colors.dart';


Widget pinkButton(BuildContext context, String text, {Function()? onPressed}) {
  return ElevatedButton(
    onPressed: () {
      if (onPressed != null) {
        onPressed();
      }
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: MyColors.pinkColor,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    child: Text(text, style: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w700,
    ) ,),
  );
}