import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/core/widgets/loader.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class ProductSearchTile extends StatelessWidget {
  final Products product;

  const ProductSearchTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 50,
        width: 60,
        child: CachedNetworkImage(
          imageUrl: product.image != null && product.image!.isNotEmpty
              ? product.image!
              : "",
          placeholder: (context, url) => const Loader(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.red),
        ),
      ),
      title: Text(product.title ?? ""),
      subtitle: Row(
        spacing: 10,
        children: [
          Text(
            "$currency ${product.price ?? ""}",
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
