import 'dart:convert';
import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/data/network/network_/network_services_api.dart';

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com";
  static final NetworkServicesApi _apiService = NetworkServicesApi();

  /// Fetch all products
  static Future<List<Product>> fetchProducts() async {
    final response = await _apiService.getApi("$baseUrl/products");
    final data = json.decode(response) as List;
    return data.map((e) => Product.fromJson(e)).toList();
  }

  /// Fetch a single product by ID
  static Future<Product> fetchProductById(int id) async {
    final response = await _apiService.getApi("$baseUrl/products/$id");
    final data = json.decode(response);
    return Product.fromJson(data);
  }
}
