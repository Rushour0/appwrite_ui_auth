import 'package:appwrite_ui_auth/classes/routes.dart';
import 'package:example/theme_notifier.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.parentState});

  final void Function() parentState;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appwrite UI Auth'),
      ),
      body: Center(
        child: Column(
            children: [
          ToggleButtons(
            onPressed: (index) {
              if (index == 0) {
                print('light');
                ThemeNotifier().setTheme = ThemeMode.light;
              } else {
                print('dark');
                ThemeNotifier().setTheme = ThemeMode.dark;
              }
              widget.parentState();
              setState(() {});
            },
            isSelected: [
              ThemeNotifier.getBrightness() == Brightness.light,
              ThemeNotifier.getBrightness() == Brightness.dark
            ],
            children: const [
              Icon(Icons.light_mode),
              Icon(Icons.dark_mode),
            ],
          ),
          Text('Theme: ${ThemeNotifier.getBrightness().name.toUpperCase()}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            width: screenWidth * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppwriteRoutes.signup);
                  },
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppwriteRoutes.signin);
                  },
                  child: const Text(
                    'Signin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppwriteRoutes.forgotPassword);
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppwriteRoutes.phoneAuth);
                  },
                  child: const Text(
                    'Phone Auth',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]
                .map((e) => Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.05),
                      child: e,
                    ))
                .toList()),
      ),
    );
  }
}
