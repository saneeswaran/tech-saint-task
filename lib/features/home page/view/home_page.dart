import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/features/home%20page/components/product_tile.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/home%20page/view%20model/product_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(productNotifier.notifier).getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifier);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: productState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (products) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductTile(
                  product: products[index],
                  onTap: () {},
                  onAddToCart: () {},
                  onFavorite: () {},
                );
              },
            );
          },
          error: (error) => Center(child: Text(error)),
        ),
      ),
    );
  }
}
