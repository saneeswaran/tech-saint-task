// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_with_product_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartWithProductHiveAdapter extends TypeAdapter<CartWithProductHive> {
  @override
  final typeId = 1;

  @override
  CartWithProductHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartWithProductHive(
      productId: (fields[0] as num).toInt(),
      quantity: (fields[1] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CartWithProductHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartWithProductHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
