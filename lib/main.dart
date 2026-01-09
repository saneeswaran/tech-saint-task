import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/constants/app_themes.dart';
import 'package:techsaint_task/core/constants/theme_notifier.dart';
import 'package:techsaint_task/features/bottom%20nav/view/bottom_navi.dart';
import 'package:techsaint_task/core/constants/main_inits.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainInits.inits();
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLight = ref.watch(themeProvider);

    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: isLight ? AppThemes.light : AppThemes.darkTheme,
      title: 'Techsaint Task',
      home: const BottomNavi(),
    );
  }
}
