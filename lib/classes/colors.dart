import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppwriteColors {
  static BuildContext? _context;

  AppwriteColors.init(BuildContext context) {
    _context = context;
  }

  static const Color primary = Color(0xFFF02E65);

  static Color get background => (_context != null
              ? Theme.of(_context!).brightness
              : SchedulerBinding.instance.window.platformBrightness) ==
          Brightness.light
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF14141F);

  static Color get text => (_context != null
              ? Theme.of(_context!).brightness
              : SchedulerBinding.instance.window.platformBrightness) ==
          Brightness.light
      ? const Color(0xFF000000)
      : const Color(0xFFFFFFFF);

  static Color get textFieldBorder => (_context != null
              ? Theme.of(_context!).brightness
              : SchedulerBinding.instance.window.platformBrightness) ==
          Brightness.light
      ? const Color(0xFF1F1F2E)
      : const Color(0xFF555555);

  static Color get textFieldBackground => (_context != null
              ? Theme.of(_context!).brightness
              : SchedulerBinding.instance.window.platformBrightness) ==
          Brightness.light
      ? const Color(0xFFF2F2F7)
      : const Color(0xFF1F1F2E);

  static const Color success = Color(0xFF219653);
  static const Color danger = Color(0xFFEB5757);
  static const Color warning = Color(0xFFF2994A);
  static const Color notice = Color(0xFFF2C94C);
}
