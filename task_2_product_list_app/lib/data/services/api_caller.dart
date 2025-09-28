import 'dart:convert';

import 'package:http/http.dart';

class ApiCaller {
  static Future<List<dynamic>> getProduct() async {
    final response = await get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}
