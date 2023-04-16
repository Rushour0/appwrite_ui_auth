import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/reset_password/components/mobile.dart';
import 'package:appwrite_ui_auth/services/appwrite_service.dart';
import 'package:flutter/material.dart';

class AppwriteResetPassword extends StatefulWidget {
  const AppwriteResetPassword({
    super.key,
    required this.title,
    required this.successCallback,
    required this.params,
  });

  /// App title or title of the screen
  final String title;

  /// Params passed to the screen
  final String params;

  /// Callback function to be called on successful login
  /// The callback function takes a [Map<String, dynamic>] as an argument which contains the user data
  /// Use this to navigate to the next screen
  final Function(Map<String, dynamic> userData) successCallback;
  @override
  State<AppwriteResetPassword> createState() => _AppwriteResetPasswordState();
}

class _AppwriteResetPasswordState extends State<AppwriteResetPassword> {
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  final TextEditingController passwordAgainController = TextEditingController();

  void onResetPassword() async {
    Map<String, String> params = {};
    widget.params.split('&').forEach((element) {
      final List<String> param = element.split('=');
      params[param[0]] = param[1];
    });

    final Map<String, dynamic> response = await AppwriteService.resetPassword(
      userId: params['userId'] ?? '',
      secret: params['secret'] ?? '',
      password: passwordController.text,
      passwordAgain: passwordAgainController.text,
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
          content: Text('Password reset successful'),
        ),
      );
    }
    await widget.successCallback(response);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    if (screenWidth <= BreakPoints.md.value) {
      return ResetPasswordMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        passwordAgainController: emailController,
        passwordController: passwordController,
        onResetPassword: onResetPassword,
      );
    } else {
      return Container();
    }
  }
}
