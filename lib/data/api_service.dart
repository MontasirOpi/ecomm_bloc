import 'package:ecomm_bloc/data/model/product_model.dart';
import 'package:ecomm_bloc/data/model/login_response.dart';
import 'package:ecomm_bloc/data/network/network_services_api.dart';

class ApiService {
  static const String baseUrl = "https://fakestoreapi.com";
  static final NetworkServicesApi _apiService = NetworkServicesApi();

  /// Fetch all products
  static Future<List<Product>> fetchProducts() async {
    final data = await _apiService.getApi("$baseUrl/products");
    return (data as List).map((e) => Product.fromJson(e)).toList();
  }

  /// Fetch a single product by ID
  static Future<Product> fetchProductById(int id) async {
    final data = await _apiService.getApi("$baseUrl/products/$id");
    return Product.fromJson(data);
  }

  /// Login user
  static Future<LoginResponse> loginUser(
    String username,
    String password,
  ) async {
    final data = await _apiService.PostApi("$baseUrl/auth/login", {
      "username": username,
      "password": password,
    });
    return LoginResponse.fromJson(data);
  }
}
