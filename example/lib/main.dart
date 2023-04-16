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
