class AppwriteRoutes {
  static const String account = '/account';
  static const String dashboard = '/dashboard';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String phoneAuth = '/phoneAuth';

  static List<String> get allRoutes => [
        account,
        dashboard,
        forgotPassword,
        signin,
        signup,
        phoneAuth,
      ];
}
