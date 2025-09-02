import 'dart:io';
import 'package:ecomm_bloc/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkServicesApi extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 50));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw Exception("No Internet Connection");
    } on HttpException {
      throw Exception("Couldn't find the data");
    } on FormatException {
      throw Exception("Invalid Format");
    }

    return jsonResponse;
  }

  @override
  Future<dynamic> PostApi(String url, var data) async {
    dynamic jsonResponse;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(Duration(seconds: 50));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw Exception("No Internet Connection");
    } on HttpException {
      throw Exception("Couldn't find the data");
    } on FormatException {
      throw Exception("Invalid Format");
    }

    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.body;
        return responseJson;
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
