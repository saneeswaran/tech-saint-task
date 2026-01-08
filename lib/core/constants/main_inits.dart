import 'dart:developer';

import 'package:hive_ce_flutter/adapters.dart';
import 'package:techsaint_task/core/manager/theme_manager.dart';
import 'package:techsaint_task/features/home%20page/service/product_hive_manager.dart';

class MainInits {
  static Future<void> inits() async {
    try {
      await Hive.initFlutter();
      ThemeManager.safeInits();
      ProductHiveManager.safeInits();
    } catch (e) {
      log("inits error: $e");
    }
  }
}
