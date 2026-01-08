import 'package:flutter/material.dart';
import 'package:techsaint_task/core/animations/cart/cart_loader.dart';

class CartListLoader extends StatelessWidget {
  const CartListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final loaders = List.generate(6, (index) => const CartLoader());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: loaders.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return loaders[index];
        },
      ),
    );
  }
}
