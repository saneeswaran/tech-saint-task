import 'package:flutter/material.dart';
import 'package:techsaint_task/core/animations/product/product_loader.dart';

class ProductLoaderGrid extends StatelessWidget {
  const ProductLoaderGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final loaders = List.generate(6, (index) => const ProductLoader());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: loaders.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.58,
        ),
        itemBuilder: (context, index) {
          return loaders[index];
        },
      ),
    );
  }
}
