// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_with_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartWithProduct _$CartWithProductFromJson(Map<String, dynamic> json) =>
    _CartWithProduct(
      product: Products.fromJson(json['product'] as Map<String, dynamic>),
      cart: CartModel.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartWithProductToJson(_CartWithProduct instance) =>
    <String, dynamic>{'product': instance.product, 'cart': instance.cart};
