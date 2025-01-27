import 'package:flutter/material.dart';
import 'package:dsw52703/utils/colors.dart';
import 'package:dsw52703/utils/images.dart';
import 'package:dsw52703/views/register/register_view.dart';
import 'package:dsw52703/views/widgets/basic_text_form_field.dart';
import 'package:dsw52703/views/widgets/header_text.dart';
import 'package:dsw52703/views/widgets/pink_button.dart';
import 'package:dsw52703/db/users_database.dart';
import 'package:dsw52703/views/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              const Spacer(flex: 62),
              // Logo
              Image.asset(MyImages.logo),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      headerText('Sign In'),
                      const SizedBox(height: 30),

                      TextFormFieldWithIcon(
                        hintText: 'Email or Username',
                        icon: Icons.person,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email or username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      TextFormFieldWithIcon(
                        hintText: 'Password',
                        icon: Icons.lock,
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),

                      _forgetPassword(context),
                      const SizedBox(height: 25),

                      pinkButton(
                        context,
                        'Sign In',
                        onPressed: _loginUser,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 350),
              _dontHaveAccount(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final user = await UsersDatabase.instance.readUserByEmail(email);
      if (user.password == password) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedInUser', email);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

Widget _forgetPassword(BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {
      },
      child: Text(
        'Forget Password?',
        style: TextStyle(
          color: MyColors.purpleColor,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _dontHaveAccount(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Don\'t have an account?',
        style: TextStyle(color: MyColors.purpleColor),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterView(),
            ),
          );
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: MyColors.purpleColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    ],
  );
}}
