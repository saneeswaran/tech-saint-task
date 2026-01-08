import 'package:flutter/material.dart';
import 'package:techsaint_task/core/constants/main_inits.dart';
import 'package:techsaint_task/features/home%20page/view/home_page.dart';

void main() async {
  await MainInits.inits();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Techsaint Task',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomePage(),
    );
  }
}
