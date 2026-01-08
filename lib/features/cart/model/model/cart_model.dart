import 'package:freezed_annotation/freezed_annotation.dart';
part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
abstract class CartModel with _$CartModel {
  const factory CartModel({int? id, @Default(1) int? quantity}) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
