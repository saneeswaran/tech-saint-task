import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/animations/product/product_laoder_grid.dart';
import 'package:techsaint_task/core/constants/theme_notifier.dart';
import 'package:techsaint_task/features/cart/view%20model/cart_notifier.dart';
import 'package:techsaint_task/features/home%20page/components/home_app_bar.dart';
import 'package:techsaint_task/features/home%20page/components/product_tile.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/home%20page/view%20model/product_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final productState = ref.watch(productNotifier);
    final isDark = ref.watch(themeProvider);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 200,
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      !isDark ? theme.cardColor : Colors.blue.shade50,
                      theme.scaffoldBackgroundColor,
                    ],
                  ),
                ),
                child: const HomeAppBar(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                "All Products",
                style: theme.textTheme.headlineSmall?.copyWith(),
              ),
            ),
          ),
          productState.when(
            initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
            loading: () => const SliverToBoxAdapter(child: ProductLoaderGrid()),
            error: (error) => SliverToBoxAdapter(
              child: Center(
                child: Text(error, style: theme.textTheme.bodyMedium),
              ),
            ),
            loaded: (products) {
              if (products.isEmpty) {
                return SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 200),
                      Center(
                        child: Text(
                          "No Products",
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 2;
                    double aspectRatio = 0.6;

                    final width = constraints.crossAxisExtent;

                    if (width >= 600 && width < 1024) {
                      crossAxisCount = 3;
                      aspectRatio = 0.65;
                    } else if (width >= 1024) {
                      crossAxisCount = 5;
                      aspectRatio = 0.7;
                    }

                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: aspectRatio,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: products.length,
                        (context, index) {
                          final product = products[index];
                          return ProductTile(
                            product: product,
                            onAddToCart: () {
                              ref
                                  .read(cartNotifier.notifier)
                                  .addToProduct(
                                    product: product,
                                    context: context,
                                  );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
