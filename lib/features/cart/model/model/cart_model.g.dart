// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartModel _$CartModelFromJson(Map<String, dynamic> json) => _CartModel(
  id: (json['id'] as num?)?.toInt(),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$CartModelToJson(_CartModel instance) =>
    <String, dynamic>{'id': instance.id, 'quantity': instance.quantity};
