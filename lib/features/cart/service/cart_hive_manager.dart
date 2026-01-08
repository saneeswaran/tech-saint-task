import 'package:hive_ce/hive.dart';
import 'package:techsaint_task/features/cart/model/model/cart_with_product_hive.dart';

class CartHiveManager {
  static const String boxName = 'cart';

  static late Box<CartWithProductHive> _box;

  static Future<void> safeInits() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CartWithProductHiveAdapter());
    }
    _box = await Hive.openBox<CartWithProductHive>(boxName);
  }

  static Future<void> addOrUpdateCart({
    required int productId,
    required int quantity,
  }) async {
    await _box.put(
      productId,
      CartWithProductHive(productId: productId, quantity: quantity),
    );
  }

  static Future<void> deleteCart(int productId) async {
    await _box.delete(productId);
  }

  static List<CartWithProductHive> getAllCarts() {
    return _box.values.toList();
  }

  static Future<void> clearCart() async {
    await _box.clear();
  }
}
