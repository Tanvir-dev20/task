import 'dart:convert';

import 'package:http/http.dart';
import 'package:product_list_app/model/product_model.dart';

class ApiCaller {
  static List<ProductModel> productList = [];
  static Future<List<ProductModel>> getProduct() async {
    final response = await get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      for (Map<String, dynamic> i in data) {
        ProductModel productModel = ProductModel.fromJson(i);
        productList.add(productModel);
      }
      return productList;
    } else {
      throw Exception('Error');
    }
  }
}
