import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techsaint_task/features/cart/model/model/cart_with_product.dart';
part 'cart_state.freezed.dart';

@freezed
abstract class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.loading() = _Loading;
  const factory CartState.loaded(List<CartWithProduct> cart) = _Loaded;
  const factory CartState.error(String error) = _Error;
}
