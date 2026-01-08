import 'package:hive_ce_flutter/adapters.dart';

part 'cart_with_product_hive.g.dart';

@HiveType(typeId: 1)
class CartWithProductHive extends HiveObject {
  @HiveField(0)
  int productId;

  @HiveField(1)
  int quantity;

  CartWithProductHive({required this.productId, required this.quantity});
}
