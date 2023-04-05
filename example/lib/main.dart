import 'package:appwrite_ui_auth/appwrite_ui_auth.dart';
import 'package:example/not_found.dart';
import 'package:flutter/material.dart';

void main() {
  AppwriteAuth.init(
    endpoint: 'https://appwrite.localhost/v1',
    projectId: '5f6d5e7e0d6c2',
    selfSigned: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/signup',
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) {
            switch (settings.name) {
              case '/signup':
                return AppwriteSignup(
                  title: 'Sample App',
                  successCallback: (token) => 'success',
                  signInRoute: '/signin',
                );
              case '/signin':
                return AppwriteSignin(
                  title: 'Sample App',
                  successCallback: (token) => 'success',
                  signUpRoute: '/signup',
                );
              default:
                const NotFound();
            }
            return const NotFound();
          });
        });
  }
}
