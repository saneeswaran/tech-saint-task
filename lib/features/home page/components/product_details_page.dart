import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techsaint_task/core/widgets/loader.dart';
import 'package:techsaint_task/features/cart/model/state/cart_state.dart';
import 'package:techsaint_task/features/cart/view%20model/cart_notifier.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: isTablet ? 350 : 300,
                stretch: true,
                pinned: true,
                snap: false,
                floating: false,
                backgroundColor: theme.colorScheme.surface,
                foregroundColor: theme.colorScheme.onSurface,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: isDarkMode
                      ? Brightness.light
                      : Brightness.dark,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  title: Text(
                    product.title ?? '',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      shadows: [
                        Shadow(color: theme.colorScheme.surface, blurRadius: 8),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  background: Hero(
                    tag: 'product-image-${product.id}',
                    child: product.image != null
                        ? CachedNetworkImage(
                            imageUrl: product.image!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) => const SizedBox(
                              height: 40,
                              width: 40,
                              child: Loader(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                          )
                        : Container(
                            color: theme.colorScheme.surfaceVariant,
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 100,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                  ),
                ),
              ),

              // Product Details
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isTablet ? 32 : 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Description
                      Text(
                        'Description',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description ?? 'No description available',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Features/Highlights
                      if (isTablet) ...[const SizedBox(height: 32)],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      // Bottom Action Bar
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 32 : 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.1),
                ),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final cartnotifier = ref.watch(cartNotifier);
                        final isAvailable = cartnotifier.maybeWhen(
                          orElse: () => false,
                          loaded: (cart) =>
                              cart.any((e) => e.product.id == product.id),
                        );
                        return FilledButton(
                          onPressed: () {
                            if (!isAvailable) {
                              ref
                                  .read(cartNotifier.notifier)
                                  .addToProduct(
                                    product: product,
                                    context: context,
                                  );
                            } else {
                              ref
                                  .read(cartNotifier.notifier)
                                  .removeProduct(product.id ?? 0, context);
                            }
                          },
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart_outlined),
                              const SizedBox(width: 8),
                              Text(
                                isAvailable
                                    ? 'Remove from Cart'
                                    : 'Add to Cart',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
