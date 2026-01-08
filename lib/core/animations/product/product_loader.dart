import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductLoader extends StatelessWidget {
  const ProductLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.58,
      child: Skeletonizer(
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
                children: [
                  SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
                        fit: BoxFit.cover,
                        placeholder: (_, _) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (_, _, _) => Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                'Product Title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'No description available',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '0.00 USD',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 18,
                                    color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
