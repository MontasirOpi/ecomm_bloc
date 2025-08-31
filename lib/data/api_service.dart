import 'dart:convert';

import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com";

  /// Fetch all products
  static Future<List<Product>> fetchProducts() async {
    final url = Uri.parse("$baseUrl/products");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      print("Products fetched successfully: $data"); // Debug print
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      print("Failed to load products: ${response.statusCode}"); // Debug print
      throw Exception("Failed to load products");
    }
  }

  /// Fetch a single product by ID
  static Future<Product> fetchProductById(int id) async {
    final url = Uri.parse("$baseUrl/products/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Product fetched successfully: ${response.body}"); // Debug print
      return Product.fromJson(json.decode(response.body));
    } else {
      print("Failed to load product: ${response.statusCode}"); // Debug print
      throw Exception("Failed to load product");
    }
  }
}
