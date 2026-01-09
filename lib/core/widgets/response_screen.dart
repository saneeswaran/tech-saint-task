import 'package:flutter/material.dart';

class ResponsiveScreen extends StatelessWidget {
  final Widget? mobileLayout;
  final Widget? tabletLayout;
  const ResponsiveScreen({super.key, this.mobileLayout, this.tabletLayout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return mobileLayout!;
          } else {
            return tabletLayout!;
          }
        },
      ),
    );
  }
}
