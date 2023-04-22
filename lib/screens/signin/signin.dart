// ignore_for_file: use_build_context_synchronously

import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/signin/components/signin_mobile.dart';
import 'package:appwrite_ui_auth/services/appwrite_service.dart';
import 'package:flutter/material.dart';

class AppwriteSignin extends StatefulWidget {
  const AppwriteSignin({
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
  State<AppwriteSignin> createState() => _AppwriteSigninState();
}

class _AppwriteSigninState extends State<AppwriteSignin> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  void onSignin() async {
    final Map<String, dynamic> response =
        await AppwriteService.loginEmailAccount(
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
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return SigninMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        emailController: emailController,
        passwordController: passwordController,
        onSignin: onSignin,
      );
    } else {
      return Container();
    }
  }
}
