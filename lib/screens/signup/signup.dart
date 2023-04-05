import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/signup/components/mobile.dart';
import 'package:flutter/material.dart';

class AppwriteSignup extends StatefulWidget {
  const AppwriteSignup({
    super.key,
    required this.title,
    required this.successCallback,
    required this.signInRoute,
  });

  final String title, signInRoute;
  final Function(String? token)? successCallback;

  @override
  State<AppwriteSignup> createState() => AppwriteSignupState();
}

class AppwriteSignupState extends State<AppwriteSignup> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    if (screenWidth <= BreakPoints.md.value) {
      return SignupMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        signInRoute: widget.signInRoute,
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
