import 'dart:convert';
import 'dart:io';
import 'package:ecomm_bloc/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkServicesApi extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 50));
      return returnResponse(response);
    } on SocketException {
      throw Exception("No Internet Connection");
    }
  }

  @override
  Future<dynamic> PostApi(String url, var data) async {
    try {
      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(data), // send as JSON
            headers: {"Content-Type": "application/json"},
          )
          .timeout(const Duration(seconds: 50));
      return returnResponse(response);
    } on SocketException {
      throw Exception("No Internet Connection");
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw Exception("Bad Request: ${response.body}");
      case 401:
      case 403:
        throw Exception("Unauthorized: ${response.body}");
      case 500:
      default:
        throw Exception(
          "Error occurred with StatusCode: ${response.statusCode}",
        );
    }
  }
}
