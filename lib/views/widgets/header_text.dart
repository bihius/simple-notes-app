import 'package:flutter/material.dart';

import '../../utils/colors.dart';

Widget headerText (String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: 30, color: MyColors.purpleColor, fontWeight: FontWeight.w700),
  );
}
