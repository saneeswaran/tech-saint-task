import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/features/home%20page/model/hive/hive_products.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';
import 'package:http/http.dart' as http;
import 'package:techsaint_task/features/home%20page/service/product_hive_manager.dart';

class ProductRepo {
  static const String _baseUrl = "https://fakestoreapi.com";
  static const String _getProducts = "$_baseUrl/products";
  static Future<Either<Failure, List<Products>>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(_getProducts));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final products = data.map((e) => Products.fromJson(e)).toList();

        //local storage
        for (final product in products) {
          final HiveProducts hiveProducts = HiveProducts(
            id: product.id!,
            description: product.description,
            image: product.image,
            price: product.price,
            title: product.title,
          );
          ProductHiveManager.addProducts(hiveProducts);
        }

        return Right(products);
      } else {
        return Left(response.body);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
