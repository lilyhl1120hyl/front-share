// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioHttpClient {
  static const _DEFAULT_CONNECT_TIMEOUT = Duration(seconds: 60);
  static const _DEFAULT_SEND_TIMEOUT = Duration(seconds: 60);
  static const _DEFAULT_RECEIVE_TIMEOUT = Duration(seconds: 60);

  final Map<String, Dio> _mClientMap = <String, Dio>{};

  DioHttpClient._internal();

  static final DioHttpClient _instance = DioHttpClient._internal();

  factory DioHttpClient.getInstance() => _instance;

  Dio getClient(String baseUrl,
      {required BaseOptions newOptions,
      required List<Interceptor> interceptors}) {
    if (baseUrl.isEmpty) {
      throw Exception('baseUrl not be allowed null');
    }

    Dio? client = _mClientMap[baseUrl];
    if (client != null) {
      client.interceptors.addAll(interceptors);
      return client;
    }

    client = _createDioClient(baseUrl, options: newOptions);
    client.interceptors.addAll(interceptors);

    client.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        // Config the client.
        client.findProxy = (uri) {
          // Forward all request to proxy "localhost:8888".
          // Be aware, the proxy should went through you running device,
          // not the host platform.
          return 'PROXY 192.168.0.191:8089';
        };
        // You can also create a new HttpClient for Dio instead of returning,
        // but a client must being returned here.
        return client;
      },
    );

    _mClientMap[baseUrl] = client;
    return client;
  }

  Dio _createDioClient(String baseUrl, {required BaseOptions options}) {
    return Dio(options);
  }

  static BaseOptions createOptions(String baseUrl,
      {required Map<String, dynamic> headers,
      required Map<String, dynamic> queryParameters}) {
    return BaseOptions(
      connectTimeout: _DEFAULT_CONNECT_TIMEOUT,
      sendTimeout: _DEFAULT_SEND_TIMEOUT,
      receiveTimeout: _DEFAULT_RECEIVE_TIMEOUT,
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return true;
      },
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  void release() {
    _mClientMap.clear();
  }
}
