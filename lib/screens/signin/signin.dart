import 'package:appwrite_ui_auth/classes/breakpoints.dart';
import 'package:appwrite_ui_auth/screens/signin/components/mobile.dart';
import 'package:flutter/material.dart';

class AppwriteSignin extends StatefulWidget {
  const AppwriteSignin({
    super.key,
    required this.title,
    required this.successCallback,
    required this.signUpRoute,
  });

  final String title, signUpRoute;
  final Function(String? token)? successCallback;
  @override
  State<AppwriteSignin> createState() => _AppwriteSigninState();
}

class _AppwriteSigninState extends State<AppwriteSignin> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    if (screenWidth <= BreakPoints.md.value) {
      return SigninMobile(
        title: widget.title,
        successCallback: widget.successCallback,
        signUpRoute: widget.signUpRoute,
        );
    } else {
      return Container();
    }
  }
}
