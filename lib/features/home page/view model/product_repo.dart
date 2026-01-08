import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:techsaint_task/core/constants/constants.dart';
import 'package:techsaint_task/core/utils/custom_snack_bar.dart';
import 'package:techsaint_task/features/home%20page/model/model/products.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  static const String _baseUrl = "https://fakestoreapi.com";
  static const String _getProducts = "$_baseUrl/products";
  static Future<Either<Failure, List<Products>>> getProducts(
    BuildContext context,
  ) async {
    try {
      final response = await http.get(Uri.parse(_getProducts));

      if (!context.mounted) {
        return const Left('context is not mounted');
      }

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final products = data.map((e) => Products.fromJson(e)).toList();
        return Right(products);
      } else {
        customSnackBar(
          context: context,
          content: response.body,
          type: SnackType.error,
        );
        return Left(response.body);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
