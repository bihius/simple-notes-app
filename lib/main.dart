import 'package:flutter/material.dart';
import 'views/login/login_view.dart';


void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: LoginView(),
  ));
}

