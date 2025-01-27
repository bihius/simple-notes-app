import 'package:flutter/material.dart';
import 'package:dsw52703/models/user.dart';
import 'package:dsw52703/db/users_database.dart';
import 'package:dsw52703/utils/colors.dart';
import 'package:dsw52703/views/login/login_view.dart';
import 'package:dsw52703/views/widgets/header_text.dart';
import 'package:dsw52703/views/widgets/back_button.dart';
import 'package:dsw52703/views/widgets/basic_text_form_field.dart';
import 'package:dsw52703/views/widgets/pink_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
        return;
      }
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );


      await UsersDatabase.instance.create(user);
      // for debbuging purposes
      // final db = await UsersDatabase.instance.database;
      // final users = await db.query(tableUsers);
      // for (var user in users) {
      //   print(user);
      // }
      // ignore: unnecessary_null_comparison
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully'),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const Spacer(flex: 62),
              backButton(context),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      headerText('Sign Up'),
                      const SizedBox(height: 40),

                      TextFormFieldWithIcon(
                        hintText: 'Full name',
                        icon: Icons.person_outline,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      TextFormFieldWithIcon(
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      TextFormFieldWithIcon(
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      TextFormFieldWithIcon(
                        hintText: 'Confirm password',
                        icon: Icons.lock_outline,
                        obscureText: true,
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 80),

                      pinkButton(
                        context,
                        'Sign Up',
                        onPressed: _registerUser,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 500),
              _alreadyHaveAccount(context),
              const Spacer(flex: 62),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _alreadyHaveAccount(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Already have an account?',
        style: TextStyle(color: MyColors.purpleColor, fontSize: 15),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
          );
        },
        child: Text(
          'Sign in',
          style: TextStyle(
            color: MyColors.purpleColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    ],
  );
}
