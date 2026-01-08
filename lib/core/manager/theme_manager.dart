import 'package:hive_ce/hive.dart';

class ThemeManager {
  static final themeKey = "lightMode";
  static final boxName = "LocalBox";

  static Future<void> safeInits() async {
    await Hive.openBox(boxName);
  }

  static bool getTheme() {
    final box = Hive.box(boxName);
    return box.get(themeKey, defaultValue: true);
  }
}
