# Appwrite UI Auth

Appwrite UI Auth is a set of screens and variable configurations used to help design and integrate Appwrite Authentication

## Feature Support

| Feature              | Android | iOS |
| -------------------- | ------- | --- |
| Email Sign Up        | ✓       | ✓   |
| Email Sign In        | ✓       | ✓   |
| Reset Password       | ✓       | ✓   |
| Phone Auth           | X       | X   |
| Other Auth Providers | X       | X   |
*Rest of the features are in development*
## Installation

```
flutter pub add appwrite_ui_auth
```

## Example

Below is an example on how to use the auth. Make sure to `await` the init method.
The class `AppwriteRoutes` makes it easier to find the `/` links for the screens. Using these routes is mandatory and not repeating the same routes for other screens should be taken care of.

```
import 'package:appwrite_ui_auth/appwrite_ui_auth.dart';
import 'package:appwrite_ui_auth/classes/colors.dart';
import 'package:appwrite_ui_auth/classes/routes.dart';
import 'package:appwrite_ui_auth/screens/phone_auth/phone_auth.dart';
import 'package:example/home.dart';
import 'package:example/not_found.dart';
import 'package:example/theme_notifier.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppwriteService.init(
    endpoint: 'https://appwrite.loca.lt/v1',
    projectId: 'appwrite-auth-ui',
    selfSigned: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeNotifier themeNotifier = ThemeNotifier();

  @override
  void initState() {
    super.initState();
  }

  state() {
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {};
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppwriteColors.primary,
          ),
        ),
        darkTheme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppwriteColors.primary,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeNotifier.getTheme(),
        title: 'Appwrite UI Auth',
        initialRoute: '/',
        onGenerateRoute: (route) {
          return MaterialPageRoute(builder: (context) {
            AppwriteColors.init(context);

            switch (route.name!.split('?')[0]) {
              case '/':
                return HomePage(parentState: state);

              case AppwriteRoutes.forgotPassword:
                return AppwriteForgotPassword(
                  title: 'Sample App',
                  successCallback: (data) => 'success',
                );
              case AppwriteRoutes.resetPassword:
                return AppwriteResetPassword(
                  title: 'Sample App',
                  successCallback: (data) => 'success',
                  params: route.name!.split('?')[1],
                );
              case AppwriteRoutes.signup:
                return AppwriteSignup(
                  title: 'Sample App',
                  successCallback: (data) => 'success',
                );
              case AppwriteRoutes.signin:
                return AppwriteSignin(
                  title: 'Sample App',
                  successCallback: (data) => 'success',
                );
              case AppwriteRoutes.phoneAuth:
                return AppwritePhoneAuth(
                  title: 'Sample App',
                  successCallback: (data) => 'success',
                );
              default:
                const NotFound();
            }
            return const NotFound();
          });
        });
  }
}
```

## Screenshots

Here are a few screens used to integrate login and signup with the help of the package

<table> <tr> <td>Sign Up</td><td>Sign In</td><tr>
<tr><td><img src="https://user-images.githubusercontent.com/72869428/230188843-69fa9a93-c287-4f1a-95cb-57de2a8719ec.jpeg"> </td> <td> <img src="https://user-images.githubusercontent.com/72869428/230187320-fd2d2d7d-0164-44d8-884c-e1ac31918f11.jpeg"></td></tr>></table>

Look of the screens overall

<table>
<tr><td>Multiple screens of auth and in dark & light themes</td></tr>
<tr><td>
<video height="200px" src="https://user-images.githubusercontent.com/72869428/230495550-bfa6aeca-15ab-4550-a28b-6cda0b9bff2c.mp4"></td>
</tr>
</table>

## Features

- The repository is open source and free for anyone to contribute to it
- Open an issue for requesting a new feature and add a label of `issue`
