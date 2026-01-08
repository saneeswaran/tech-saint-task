import 'package:flutter/material.dart';
import 'package:techsaint_task/features/cart/view/cart_page.dart';
import 'package:techsaint_task/features/home%20page/view/home_page.dart';

final List<BottomNavigationBarItem> bottomNavItems = const [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Cart'),
];

final List<Widget> bottomNaviPages = const [HomePage(), CartPage()];
