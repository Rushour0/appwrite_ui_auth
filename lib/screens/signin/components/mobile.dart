import 'package:appwrite_ui_auth/appwrite_svg.dart';
import 'package:appwrite_ui_auth/classes/colors.dart';
import 'package:appwrite_ui_auth/common/button.dart';
import 'package:appwrite_ui_auth/common/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninMobile extends StatelessWidget {
  SigninMobile({
    super.key,
    required this.title,
    required this.successCallback,
    required this.signUpRoute,
  });

  final String title, signUpRoute;
  final Function(String?)? successCallback;
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();

  final ValueKey<bool> checkbox = const ValueKey(false);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final EdgeInsets screenPadding = MediaQuery.of(context).padding;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppwriteColors.background,
      body: Padding(
        padding: EdgeInsets.only(
          top: screenPadding.top,
          left: screenWidth * 0.1,
          right: screenWidth * 0.1,
        ),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.1,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.string(
                            appwriteSvgString,
                            width: screenWidth * 0.3,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  color: AppwriteColors.text,
                                  fontSize: screenHeight * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppwriteColors.text.withAlpha(192),
                                  fontSize: screenHeight * 0.035,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        ]
                            .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: screenHeight * 0.05),
                                child: e))
                            .toList()),
                  ),
                ),
                Column(
                  children: [
                    AppwriteTextField(
                      controller: _emailController,
                      labelText: 'Email',
                    ),
                    AppwriteTextField(
                      controller: _passwordController,
                      labelText: 'Password',
                      obscureText: true,
                    ),
                  ],
                ),
                Column(
                    children: [
                  AppwriteElevatedButton(
                    text: 'Sign In',
                    onPressed: () async {},
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Forgot Password ?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppwriteColors.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: '  |  ',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await Navigator.pushNamedAndRemoveUntil(
                                  context, signUpRoute, (route) => false);
                            },
                          style: TextStyle(
                            color: AppwriteColors.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await Navigator.pushNamedAndRemoveUntil(
                                  context, signUpRoute, (route) => false);
                            },
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppwriteColors.text,
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w100,
                          ),
                        )
                      ],
                    ),
                  ),
                ]
                        .map((e) => Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.025,
                              // bottom: screenHeight * 0.025,
                            ),
                            child: e))
                        .toList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
