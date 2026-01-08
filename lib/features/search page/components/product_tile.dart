import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/core/widgets/loader.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class ProductTile extends StatelessWidget {
  final Products product;
  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RepaintBoundary(
      //background container
      key: UniqueKey(),
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          //inside the container
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  //inside the stack
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 1,
                      child: CachedNetworkImage(
                        cacheKey: product.id.toString(),
                        fit: BoxFit.cover,
                        imageUrl:
                            product.image != null && product.image!.isNotEmpty
                            ? product.image!
                            : "",
                        placeholder: (context, url) =>
                            const Center(child: Loader()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),

                  //rating button
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.title}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${product.description}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.arrow_downward_outlined,
                          color: Colors.green,
                        ),
                        const Text(
                          "10%",
                          style: TextStyle(color: Colors.green),
                        ),
                        Text(
                          "$currency ${product.price}",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
