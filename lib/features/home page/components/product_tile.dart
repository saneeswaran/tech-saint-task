import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/features/home%20page/components/product_details_page.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class ProductTile extends StatelessWidget {
  final Products product;
  final VoidCallback? onAddToCart;

  const ProductTile({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 200;

        final imageHeight = isTablet ? 160.0 : 120.0;
        final titleSize = isTablet ? 16.0 : 14.0;
        final descSize = isTablet ? 13.0 : 11.0;
        final priceSize = isTablet ? 16.0 : 14.0;
        final buttonSize = isTablet ? 40.0 : 34.0;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Image
                SizedBox(
                  height: imageHeight,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: product.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (_, _) => const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      errorWidget: (_, _, _) => Container(
                        color: theme.dividerColor.withOpacity(0.2),
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 40,
                          color: theme.disabledColor,
                        ),
                      ),
                    ),
                  ),
                ),

                // Details
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 14 : 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title ?? 'Product Title',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleMedium?.copyWith(
                                fontSize: titleSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              product.description ?? 'No description available',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: descSize,
                                color: theme.hintColor,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$currency ${product.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: textTheme.titleMedium?.copyWith(
                                fontSize: priceSize,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            Container(
                              width: buttonSize,
                              height: buttonSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: theme.cardColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.shadowColor.withOpacity(0.06),
                                    blurRadius: 20,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: onAddToCart,
                                icon: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: isTablet ? 20 : 18,
                                  color: theme.iconTheme.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
