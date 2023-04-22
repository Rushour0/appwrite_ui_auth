// ignore_for_file: use_build_context_synchronously

import 'package:appwrite_ui_auth/appwrite_ui_auth.dart';
import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/signup/components/signup_mobile.dart';
import 'package:flutter/material.dart';

class AppwriteSignup extends StatefulWidget {
  const AppwriteSignup({
    super.key,
    required this.title,
    required this.successCallback,
  });

  /// App title or title of the screen
  final String title;

  /// Callback function to be called on successful login
  /// The callback function takes a [Map<String, dynamic>] as an argument which contains the user data
  /// Use this to navigate to the next screen
  final Function(Map<String, dynamic> userData) successCallback;

  @override
  State<AppwriteSignup> createState() => AppwriteSignupState();
}

class AppwriteSignupState extends State<AppwriteSignup> {
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();
  void onSignup() async {
    final Map<String, dynamic> response =
        await AppwriteService.createEmailAccount(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    if (response['error'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
      return;
    }
    await widget.successCallback(response);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return SignupMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        onSignup: onSignup,
      );
    } else if (screenWidth < BreakPoints.lg.value) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.blue,
              ),
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.blue,
              ),
              Container(
                height: screenHeight * 0.5,
                width: screenWidth,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    }
  }
}
