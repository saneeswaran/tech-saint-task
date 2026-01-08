import 'package:flutter_riverpod/legacy.dart';
import 'package:techsaint_task/features/home%20page/cart/model/model/cart_model.dart';
import 'package:techsaint_task/features/home%20page/cart/model/model/cart_with_product.dart';
import 'package:techsaint_task/features/home%20page/cart/model/state/cart_state.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

class CartProvider extends StateNotifier<CartState> {
  CartProvider() : super(const CartState.initial());

  void addToProduct(Products product) {
    final CartModel cart = CartModel(id: product.id, quantity: 1);
    final CartWithProduct cartWithProduct = CartWithProduct(
      product: product,
      cart: cart,
    );
    state = CartState.loaded([cartWithProduct]);
  }

  double getProductAmount(String productId) {
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
}
