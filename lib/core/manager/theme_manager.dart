import 'package:hive_ce/hive.dart';

class ThemeManager {
  static const String themeKey = "lightMode";
  static const String boxName = "LocalBox";

  static late Box box;

  static Future<void> safeInits() async {
    box = await Hive.openBox(boxName);
  }

  static bool getTheme() {
    final value = box.get(themeKey);
    if (value == null) {
      box.put(themeKey, true);
      return true;
    }
    return value as bool;
  }

  static Future<void> toggleTheme({bool? isLightMode}) async {
    final current = getTheme();
    final value = isLightMode ?? !current;
    await box.put(themeKey, value);
  }
}
