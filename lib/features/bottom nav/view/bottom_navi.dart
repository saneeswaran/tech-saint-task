import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/constants/theme_notifier.dart';
import 'package:techsaint_task/features/bottom%20nav/model/bottom_items.dart';

class BottomNavi extends ConsumerStatefulWidget {
  const BottomNavi({super.key});

  @override
  ConsumerState<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends ConsumerState<BottomNavi> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLightTheme = ref.watch(themeProvider);

    final selectedColor = isLightTheme ? Colors.pinkAccent : Colors.pink[200];
    final unselectedColor = isLightTheme
        ? Colors.grey.shade500
        : Colors.grey.shade400;
    final backgroundColor = isLightTheme
        ? Colors.white
        : const Color(0xFF1F1F1F);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        currentIndex: currentIndex,
        items: bottomNavItems,
        selectedItemColor: selectedColor,
        unselectedItemColor: unselectedColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: bottomNaviPages[currentIndex],
    );
  }
}
