import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:techsaint_task/features/home%20page/model/state/product_state.dart';
import 'package:techsaint_task/features/home%20page/view%20model/product_repo.dart';

final productNotifier = StateNotifierProvider<ProductProvider, ProductState>(
  (ref) => ProductProvider(),
);

class ProductProvider extends StateNotifier<ProductState> {
  ProductProvider() : super(const ProductState.initial());

  Future<void> getProducts(BuildContext context) async {
    try {
      state = const ProductState.loading();
      final result = await ProductRepo.getProducts(context);

      result.fold(
        (error) => state = ProductState.error(error),
        (products) => state = ProductState.loaded(products),
      );
    } catch (e) {
      state = ProductState.error(e.toString());
    }
  }
}
