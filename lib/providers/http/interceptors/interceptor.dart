import 'dart:async';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

import 'custom_on_request.dart';

class AppInterceptors extends Interceptor {
  AppInterceptors();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final reqOptions = await customOnRequest(options);
    handler.next(reqOptions);
  }

  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    log(response.toString());
      handler.next(response);
  }
}
