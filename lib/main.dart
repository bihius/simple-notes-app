import 'package:flutter/material.dart';
import 'views/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/home/home_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final loggedInUser = prefs.getString('loggedInUser');

  runApp(MaterialApp(
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: loggedInUser == null ? LoginView() : HomeView(),
  ));
}

