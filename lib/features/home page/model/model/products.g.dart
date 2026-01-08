// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Products _$ProductsFromJson(Map<String, dynamic> json) => _Products(
  id: json['id'] as String?,
  title: json['title'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  description: json['description'] as String?,
  category: json['category'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$ProductsToJson(_Products instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'price': instance.price,
  'description': instance.description,
  'category': instance.category,
  'image': instance.image,
};
