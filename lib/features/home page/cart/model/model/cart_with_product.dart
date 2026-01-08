import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techsaint_task/features/home%20page/cart/model/model/cart_model.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

part 'cart_with_product.freezed.dart';
part 'cart_with_product.g.dart';

@freezed
abstract class CartWithProduct with _$CartWithProduct {
  const factory CartWithProduct({
    required Products product,
    required CartModel cart,
  }) = _CartWithProduct;

  factory CartWithProduct.fromJson(Map<String, dynamic> json) =>
      _$CartWithProductFromJson(json);
}
