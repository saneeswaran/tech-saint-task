import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/constants/app_themes.dart';
import 'package:techsaint_task/core/constants/main_inits.dart';
import 'package:techsaint_task/features/bottom%20nav/view/bottom_navi.dart';

void main() async {
  await MainInits.inits();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.defaultTheme,
      title: 'Techsaint Task',
      home: const BottomNavi(),
    );
  }
}
