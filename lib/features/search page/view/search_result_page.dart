import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/features/cart/view%20model/cart_notifier.dart';
import 'package:techsaint_task/features/home%20page/components/product_tile.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class SearchResultPage extends StatefulWidget {
  final List<Products> products;
  const SearchResultPage({super.key, required this.products});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Results"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 2;
            double aspectRatio = 0.6;

            final width = constraints.maxWidth;

            if (width >= 600 && width < 1024) {
              crossAxisCount = 3;
              aspectRatio = 0.65;
            } else if (width >= 1024) {
              crossAxisCount = 5;
              aspectRatio = 0.7;
            }

            if (widget.products.isEmpty) {
              return const Center(child: Text("No products found"));
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: aspectRatio,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final product = widget.products[index];
                return Consumer(
                  builder: (context, ref, child) {
                    return ProductTile(
                      product: product,
                      onAddToCart: () {
                        ref
                            .read(cartNotifier.notifier)
                            .addToProduct(product: product, context: context);
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
