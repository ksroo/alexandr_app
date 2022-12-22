import 'dart:io';
import 'package:alexandr_test_app/app/error/exceptions.dart';
import 'package:alexandr_test_app/app/services/api_services.dart';
import 'package:alexandr_test_app/app/services/api_status.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:alexandr_test_app/app/app_injector.dart' as di;

import 'api_interceptors.dart';

class DioConsumer implements ApiServices {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    client.interceptors.add(di.sl<ApiIntercepters>());

    if (kDebugMode) {
      client.interceptors.add(di.sl<LogInterceptor>());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await client.get(path, queryParameters: query);

      return response.data;
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      bool formDataEnabled = false,
      Map<String, dynamic>? query}) async {
    try {
      final response = await client.post(
        path,
        queryParameters: query,
        data: formDataEnabled ? FormData.fromMap(body!) : body,
      );

      return response.data;
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body, Map<String, dynamic>? query}) async {
    try {
      final response =
          await client.put(path, queryParameters: query, data: body);

      return response.data;
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.confilct:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }
}
