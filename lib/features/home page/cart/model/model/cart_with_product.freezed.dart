// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_with_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CartWithProduct {

 Products get product; CartModel get cart;
/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartWithProductCopyWith<CartWithProduct> get copyWith => _$CartWithProductCopyWithImpl<CartWithProduct>(this as CartWithProduct, _$identity);

  /// Serializes this CartWithProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartWithProduct&&(identical(other.product, product) || other.product == product)&&(identical(other.cart, cart) || other.cart == cart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,product,cart);

@override
String toString() {
  return 'CartWithProduct(product: $product, cart: $cart)';
}


}

/// @nodoc
abstract mixin class $CartWithProductCopyWith<$Res>  {
  factory $CartWithProductCopyWith(CartWithProduct value, $Res Function(CartWithProduct) _then) = _$CartWithProductCopyWithImpl;
@useResult
$Res call({
 Products product, CartModel cart
});


$ProductsCopyWith<$Res> get product;$CartModelCopyWith<$Res> get cart;

}
/// @nodoc
class _$CartWithProductCopyWithImpl<$Res>
    implements $CartWithProductCopyWith<$Res> {
  _$CartWithProductCopyWithImpl(this._self, this._then);

  final CartWithProduct _self;
  final $Res Function(CartWithProduct) _then;

/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? product = null,Object? cart = null,}) {
  return _then(_self.copyWith(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Products,cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as CartModel,
  ));
}
/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductsCopyWith<$Res> get product {
  
  return $ProductsCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartModelCopyWith<$Res> get cart {
  
  return $CartModelCopyWith<$Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartWithProduct].
extension CartWithProductPatterns on CartWithProduct {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartWithProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartWithProduct() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartWithProduct value)  $default,){
final _that = this;
switch (_that) {
case _CartWithProduct():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartWithProduct value)?  $default,){
final _that = this;
switch (_that) {
case _CartWithProduct() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Products product,  CartModel cart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartWithProduct() when $default != null:
return $default(_that.product,_that.cart);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Products product,  CartModel cart)  $default,) {final _that = this;
switch (_that) {
case _CartWithProduct():
return $default(_that.product,_that.cart);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Products product,  CartModel cart)?  $default,) {final _that = this;
switch (_that) {
case _CartWithProduct() when $default != null:
return $default(_that.product,_that.cart);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CartWithProduct implements CartWithProduct {
  const _CartWithProduct({required this.product, required this.cart});
  factory _CartWithProduct.fromJson(Map<String, dynamic> json) => _$CartWithProductFromJson(json);

@override final  Products product;
@override final  CartModel cart;

/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartWithProductCopyWith<_CartWithProduct> get copyWith => __$CartWithProductCopyWithImpl<_CartWithProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartWithProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartWithProduct&&(identical(other.product, product) || other.product == product)&&(identical(other.cart, cart) || other.cart == cart));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,product,cart);

@override
String toString() {
  return 'CartWithProduct(product: $product, cart: $cart)';
}


}

/// @nodoc
abstract mixin class _$CartWithProductCopyWith<$Res> implements $CartWithProductCopyWith<$Res> {
  factory _$CartWithProductCopyWith(_CartWithProduct value, $Res Function(_CartWithProduct) _then) = __$CartWithProductCopyWithImpl;
@override @useResult
$Res call({
 Products product, CartModel cart
});


@override $ProductsCopyWith<$Res> get product;@override $CartModelCopyWith<$Res> get cart;

}
/// @nodoc
class __$CartWithProductCopyWithImpl<$Res>
    implements _$CartWithProductCopyWith<$Res> {
  __$CartWithProductCopyWithImpl(this._self, this._then);

  final _CartWithProduct _self;
  final $Res Function(_CartWithProduct) _then;

/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? product = null,Object? cart = null,}) {
  return _then(_CartWithProduct(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Products,cart: null == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as CartModel,
  ));
}

/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductsCopyWith<$Res> get product {
  
  return $ProductsCopyWith<$Res>(_self.product, (value) {
    return _then(_self.copyWith(product: value));
  });
}/// Create a copy of CartWithProduct
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartModelCopyWith<$Res> get cart {
  
  return $CartModelCopyWith<$Res>(_self.cart, (value) {
    return _then(_self.copyWith(cart: value));
  });
}
}

// dart format on
