// ignore_for_file: use_build_context_synchronously

import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/forgot_password/components/forgot_password_mobile.dart';
import 'package:appwrite_ui_auth/services/appwrite_service.dart';
import 'package:flutter/material.dart';

class AppwriteForgotPassword extends StatefulWidget {
  const AppwriteForgotPassword({
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
  State<AppwriteForgotPassword> createState() => _AppwriteForgotPasswordState();
}

class _AppwriteForgotPasswordState extends State<AppwriteForgotPassword> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  void onSend() async {
    final Map<String, dynamic> response =
        await AppwriteService.resetEmailPassword(
      email: emailController.text,
    );

    if (response['error'] ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password reset link sent to ${emailController.text}'),
        ),
      );
    }

    await widget.successCallback(response);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= BreakPoints.md.value) {
      return ForgotPasswordMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        emailController: emailController,
        passwordController: passwordController,
        onSend: onSend,
      );
    } else {
      return Container();
    }
  }
}
