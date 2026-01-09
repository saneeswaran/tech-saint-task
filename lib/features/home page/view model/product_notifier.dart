import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:techsaint_task/core/utils/utils.dart';
import 'package:techsaint_task/features/home%20page/model/hive/hive_products.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/home%20page/service/product_hive_manager.dart';
import 'package:techsaint_task/features/home%20page/view%20model/product_repo.dart';

final searchProductNotifier = Provider.family<List<Products>, String>((
  ref,
  query,
) {
  final productState = ref.watch(productNotifier);

  return productState.maybeWhen(
    loaded: (products) {
      if (query.isEmpty) return products;
      return products
          .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    },
    orElse: () => [],
  );
});

final productNotifier = StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier()..getProducts(),
);

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(const ProductState.initial());

  List<Products> _allProducts = [];

  Future<void> getProducts() async {
    state = const ProductState.loading();

    try {
      final hasInternet = await Utils.checkInternetConnection();

      //  load from Hive
      if (!hasInternet) {
        final localProducts = await ProductHiveManager.getAllproducts();

        final convertedProducts = localProducts
            .map(
              (e) => Products(
                id: e.id,
                title: e.title,
                image: e.image,
                description: e.description,
                price: e.price,
              ),
            )
            .toList();

        _allProducts = convertedProducts;
        state = ProductState.loaded(_allProducts);
        return;
      }

      //  fetch from API
      final result = await ProductRepo.getProducts();

      result.fold(
        (error) {
          state = ProductState.error(error);
        },
        (products) async {
          _allProducts = products;
          final hiveProduct = products
              .map((e) => HiveProducts.fromProducts(e))
              .toList();
          // Clear & cache ONLY after successful fetch
          await ProductHiveManager.clearProducts();
          await ProductHiveManager.addProducts(hiveProduct);

          state = ProductState.loaded(_allProducts);
        },
      );
    } catch (e) {
      state = ProductState.error(e.toString());
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      state = ProductState.loaded(_allProducts);
    } else {
      final filteredProducts = _allProducts
          .where((e) => e.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = ProductState.loaded(filteredProducts);
    }
  }

  @override
  void dispose() {
    _allProducts = [];
    super.dispose();
  }
}
