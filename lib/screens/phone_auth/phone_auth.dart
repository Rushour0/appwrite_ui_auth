// ignore_for_file: use_build_context_synchronously

import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/phone_auth/components/mobile.dart';
import 'package:appwrite_ui_auth/services/appwrite_service.dart';
import 'package:flutter/material.dart';

class AppwritePhoneAuth extends StatefulWidget {
  const AppwritePhoneAuth({
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
  State<AppwritePhoneAuth> createState() => _AppwritePhoneAuthState();
}

class _AppwritePhoneAuthState extends State<AppwritePhoneAuth> {
  final TextEditingController phoneNumberController = TextEditingController(),
      passwordController = TextEditingController();

  void onPhoneSignin() async {
    final Map<String, dynamic> response =
        await AppwriteService.createPhoneAccount(
      phone: phoneNumberController.text,
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
      return PhoneAuthMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        phoneNumberController: phoneNumberController,
        onSend: onPhoneSignin,
      );
    } else {
      return Container();
    }
  }
}
