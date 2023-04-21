import 'package:appwrite_ui_auth/classes/colors.dart';
import 'package:flutter/material.dart';

class AppwriteTextField extends StatefulWidget {
  const AppwriteTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.phone = false,
    this.errorText = '',
    this.errorBool = false,
  });
  final TextEditingController controller;
  final String labelText, errorText;
  final bool obscureText, phone, errorBool;

  @override
  State<AppwriteTextField> createState() => _AppwriteTextFieldState();
}

class _AppwriteTextFieldState extends State<AppwriteTextField> {
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(
              color: AppwriteColors.text,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextFormField(
            controller: widget.controller,
            obscureText: obscureText,
            keyboardType:
                widget.phone ? TextInputType.phone : TextInputType.text,
            style: TextStyle(
              color: AppwriteColors.text,
            ),
            decoration: InputDecoration(
              hintText: widget.labelText,
              hintStyle: TextStyle(
                color: AppwriteColors.textFieldBorder,
              ),
              // labelText: widget.labelText,
              errorText: widget.errorBool ? widget.errorText : null,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppwriteColors.textFieldBorder,
                      ),
                    )
                  : null,
              fillColor: AppwriteColors.textFieldBorder,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppwriteColors.textFieldBorder,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppwriteColors.primary,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppwriteColors.primary,
                ),
              ),
            ),
          ),
        ]
            .map((e) => Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.015,
                  ),
                  child: e,
                ))
            .toList());
  }
}
