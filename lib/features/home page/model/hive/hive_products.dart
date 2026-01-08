// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_ce/hive.dart';

part 'hive_products.g.dart';

@HiveType(typeId: 0)
class HiveProducts extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final double? price;
  HiveProducts({this.id, this.title, this.description, this.image, this.price});
}
