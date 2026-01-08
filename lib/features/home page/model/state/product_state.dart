import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';
part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(List<Products> products) = _Loaded;
  const factory ProductState.error(String error) = _Error;
}
