import 'package:flutter_riverpod/legacy.dart';
import 'package:techsaint_task/core/manager/theme_manager.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(ThemeManager.getTheme());

  void toggleTheme() {
    state = !state;
    ThemeManager.toggleTheme(isLightMode: state);
  }

  void setTheme(bool value) {
    state = value;
    ThemeManager.toggleTheme(isLightMode: value);
  }
}

// Riverpod provider
final themeProvider = StateNotifierProvider<ThemeNotifier, bool>(
  (ref) => ThemeNotifier(),
);
