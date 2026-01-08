import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:techsaint_task/core/utils/custom_snack_bar.dart';
import 'package:techsaint_task/features/cart/model/model/cart_model.dart';
import 'package:techsaint_task/features/cart/model/model/cart_with_product.dart';
import 'package:techsaint_task/features/cart/model/state/cart_state.dart';
import 'package:techsaint_task/features/cart/service/cart_hive_manager.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';
import 'package:techsaint_task/features/home%20page/service/product_hive_manager.dart';

final cartNotifier = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState.loaded([])) {
    loadCartFromHive();
  }

  Future<void> loadCartFromHive() async {
    final hiveItems = CartHiveManager.getAllCarts();
    final hiveProducts = await ProductHiveManager.getAllproducts();

    final cartItems = hiveItems.map((e) {
      final product = hiveProducts.firstWhere(
        (p) => p.id == e.productId,
        orElse: () =>
            throw Exception('Product not found for id ${e.productId}'),
      );

      final Products products = Products(
        id: product.id,
        title: product.title,
        image: product.image,
        description: product.description,
        price: product.price,
        category: product.category,
      );

      return CartWithProduct(
        product: products,
        cart: CartModel(id: e.productId, quantity: e.quantity),
      );
    }).toList();

    state = CartState.loaded(cartItems);
  }

  Future<void> addToProduct({
    required Products product,
    required BuildContext context,
  }) async {
    try {
      final oldData = state.maybeWhen(
        loaded: (data) => data,
        orElse: () => <CartWithProduct>[],
      );

      final convertedData = List<CartWithProduct>.from(oldData);

      final int index = convertedData.indexWhere(
        (e) => e.product.id == product.id,
      );

      // Product already exists
      if (index != -1) {
        customSnackBar(
          context: context,
          content: "Product already in cart",
          type: SnackType.info,
        );
        return;
      }

      // Add new product
      final cart = CartModel(id: product.id, quantity: 1);
      final cartWithProduct = CartWithProduct(product: product, cart: cart);

      await CartHiveManager.addOrUpdateCart(
        productId: product.id ?? 0,
        quantity: 1,
      );

      state = CartState.loaded([...convertedData, cartWithProduct]);
      if (!context.mounted) return;
      customSnackBar(
        context: context,
        content: "Product added to cart",
        type: SnackType.success,
      );
    } catch (e) {
      customSnackBar(
        context: context,
        content: e.toString(),
        type: SnackType.error,
      );
    }
  }

  double getProductAmount(int productId) {
    final oldData = state.maybeWhen(orElse: () => [], loaded: (data) => data);
    final conveteddata = List<CartWithProduct>.from(oldData);

    final int index = conveteddata.indexWhere((e) => e.product.id == productId);

    final amount =
        conveteddata[index].cart.quantity! * conveteddata[index].product.price!;
    return amount;
  }

  double getTotalCartAmount() {
    double totalAmount = 0.0;
    final oldData = state.maybeWhen(orElse: () => [], loaded: (data) => data);
    final convertedData = List<CartWithProduct>.from(oldData);

    for (final cart in convertedData) {
      totalAmount += cart.cart.quantity! * cart.product.price!;
    }
    return totalAmount;
  }

  Future<void> removeProduct(int productId) async {
    final oldData = state.maybeWhen(orElse: () => [], loaded: (data) => data);
    final convertedData = List<CartWithProduct>.from(oldData);
    final index = convertedData.indexWhere((e) => e.product.id == productId);
    convertedData.removeAt(index);
    await CartHiveManager.deleteCart(productId);
    state = CartState.loaded(convertedData);
  }

  void increaseQuantity({required int productId}) {
    final currentData = state.maybeWhen(
      loaded: (data) => data,
      orElse: () => <CartWithProduct>[],
    );

    final updatedList = currentData.map((item) {
      if (item.product.id == productId) {
        return CartWithProduct(
          product: item.product,
          cart: item.cart.copyWith(quantity: item.cart.quantity! + 1),
        );
      }
      return item;
    }).toList();

    state = CartState.loaded(updatedList);
  }

  Future<void> decreaseQuantity({
    required int productId,
    required BuildContext context,
  }) async {
    final currentData = state.maybeWhen(
      loaded: (data) => data,
      orElse: () => <CartWithProduct>[],
    );

    final List<CartWithProduct> updatedList = [];
    bool isRemoved = false;

    for (final item in currentData) {
      if (item.product.id == productId) {
        final newQuantity = item.cart.quantity! - 1;

        // Remove product if quantity reaches 0
        if (newQuantity > 0) {
          updatedList.add(
            CartWithProduct(
              product: item.product,
              cart: item.cart.copyWith(quantity: newQuantity),
            ),
          );
        } else {
          isRemoved = true;
          await CartHiveManager.deleteCart(productId);
        }
      } else {
        updatedList.add(item);
      }
    }

    state = CartState.loaded(updatedList);
    if (!context.mounted) return;
    if (isRemoved) {
      customSnackBar(
        context: context,
        content: "Product removed from cart",
        type: SnackType.error,
      );
    }
  }

  @override
  void dispose() {
    state = const CartState.initial();
    super.dispose();
  }
}
