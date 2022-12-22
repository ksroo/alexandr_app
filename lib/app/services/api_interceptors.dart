import 'package:alexandr_test_app/app/log/app_log.dart';
import 'package:dio/dio.dart';

class ApiIntercepters extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLog.log('REQUEST[${options.method}] => PATH: ${options.path}');
    var headers = {
      "Content-Type": "application/json",
    };
    options.headers = headers;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLog.log(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    AppLog.log(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
