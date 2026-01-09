import 'package:hive_ce_flutter/adapters.dart';
import 'package:techsaint_task/features/home%20page/model/hive/hive_products.dart';

class ProductHiveManager {
  static final String productKey = 'productKey';
  static final String boxName = 'productBox';

  static Future<void> safeInits() async {
    Hive.registerAdapter<HiveProducts>(HiveProductsAdapter());
    await Hive.openBox<HiveProducts>(boxName);
  }

  static Future<void> addProducts(List<HiveProducts> hiveProduct) async {
    final box = Hive.box<HiveProducts>(boxName);
    for (final product in hiveProduct) {
      await box.put(product.id, product);
    }
  }

  static Future<void> deleteproduct(int id) async {
    final box = Hive.box<HiveProducts>(boxName);
    await box.delete(id);
  }

  static Future<void> updateProduct(HiveProducts hiveProduct) async {
    final box = Hive.box<HiveProducts>(boxName);
    await box.put(hiveProduct.id, hiveProduct);
  }

  static Future<List<HiveProducts>> getAllproducts() async {
    final box = Hive.box<HiveProducts>(boxName);
    return box.values.toList();
  }

  static Future<void> clearProducts() async {
    final box = Hive.box<HiveProducts>(boxName);
    await box.clear();
  }
}
