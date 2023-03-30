import 'dart:convert';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

Future<RequestOptions> customOnRequest(
  RequestOptions options,
) async {
  options.headers.addAll({
    'x-api-key':
        'live_zeSoA4cwZMSQhffnJxxR8wqvUOtD1fppTf1ukvIrliZr3zc8L9pPT7ciSar2KAYS'
  });
  _printInfoRequest(options);
  return options;
}

void _printInfoRequest(RequestOptions options) {
  log('baseURL: ${options.baseUrl}\npath: ${options.path}');
  log('headers: ${options.headers}');
  log('queryParameters: ${options.queryParameters}');
  if (options.data is! FormData) log('data : ${jsonEncode(options.data)}');
}
