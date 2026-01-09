// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_ce/hive.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';

part 'hive_products.g.dart';

@HiveType(typeId: 0)
class HiveProducts extends HiveObject {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final double? price;
  @HiveField(5)
  final String? category;
  HiveProducts({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
    this.category,
  });

  factory HiveProducts.fromProducts(Products products) => HiveProducts(
    id: products.id,
    title: products.title,
    description: products.description,
    image: products.image,
    price: products.price,
    category: products.category,
  );
}
