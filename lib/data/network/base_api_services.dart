abstract class BaseApiServices {
  Future<dynamic> getApi(String url);
  Future<dynamic> PostApi(String url, dynamic data);
}
