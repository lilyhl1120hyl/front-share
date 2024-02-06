import 'package:dio/dio.dart';
import 'package:flutter_bloc_dio/src/config/common_config.dart';

final dio = Dio();

Future getHttp(url, data) async {
  final response = await dio.get(baseUrl + url, queryParameters: data);
  print('get: $response');
  print(response.data.toString());
  return response;
}

Future postHttp(url, data) async {
  final response = await dio.post(baseUrl + url, data: data);
  print('post: $response');
  print(response.data.toString());
  return response;
}

Future formDataHttp(url, data) async {
  final formData = FormData.fromMap(data);
  final response = await dio.post(baseUrl + url, data: formData);
  print('formData: $response');
  print(response.data.toString());
  return response;
}
