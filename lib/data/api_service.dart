import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/product_model.dart';

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com";

  /// Fetch all products
  static Future<List<Product>> fetchProducts() async {
    final url = Uri.parse("$baseUrl/products");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  /// Fetch a single product by ID
  static Future<Product> fetchProductById(int id) async {
    final url = Uri.parse("$baseUrl/products/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load product");
    }
  }
}
