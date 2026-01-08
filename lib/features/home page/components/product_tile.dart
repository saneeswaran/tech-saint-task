import 'package:flutter/material.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class ProductTile extends StatelessWidget {
  final Products product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavorite;

  const ProductTile({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.grey.shade50,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      product.image ?? '',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey.shade400,
                                  size: 40,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'No Image',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Product Title
                      Text(
                        product.title ?? 'Product Title',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Product Description
                      Text(
                        product.description ?? 'No description available',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 12),

                      // Price and Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Price
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2E3A59),
                                ),
                              ),
                              Text(
                                'USD',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          // Add to Cart Button
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF667EEA,
                                  ).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: onAddToCart,
                              icon: const Icon(
                                Icons.add_shopping_cart_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Favorite Button
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: onFavorite,
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 18,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
