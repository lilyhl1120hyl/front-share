// ignore_for_file: constant_identifier_names
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_bloc_dio/src/api/config/configHeader.dart';
import 'package:flutter_bloc_dio/src/components/toast/show_toast.dart';
import 'package:flutter_bloc_dio/src/config/common_config.dart';
import 'package:flutter_bloc_dio/src/config/common_global.dart';
import 'package:flutter_bloc_dio/src/model/api_models/base_model/base_res.dart';

class HttpHelper {
  static Dio? mDio;
  static BaseOptions? options;
  static HttpHelper? httpHelper;

  static const String BASE_URL = baseUrl;

  CancelToken cancelToken = CancelToken();

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static HttpHelper? get instance => getInstance();

  static Dio? get dio => getDio();

  static HttpHelper? getInstance() {
    httpHelper ??= HttpHelper();
    return httpHelper;
  }

  static Dio? getDio() {
    // final String token = Global.userProfile.token ?? "empty token";
    print("headerMap11: ");
    // 设置请求头
    // const String token = "empty token";
    // const Map<String, dynamic> headerMap = httpheaders;
    // headerMap.putIfAbsent("Authorization", () => "Bearer $token");

    // print("headerMap: $headerMap");

    options = BaseOptions(
      //请求基地址,可以包含子路径
      baseUrl: BASE_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: const Duration(seconds: 10),
      //2.x中为接收数据的最长时限
      receiveTimeout: const Duration(seconds: 5),
      //Http请求头.
      headers: httpheaders,
      // 请求的Content-Type，默认值是"application/json; charset=utf-8".
      //   /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      //   /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      //   /// 就会自动编码请求体.
      contentType: Headers.jsonContentType,

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    mDio = Dio(options);
    mDio?.interceptors.add(interceptorsWrapper());

    // mDio?.httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () {
    //     final client = HttpClient();
    //     client.findProxy = (uri) {
    //       // Proxy all request to localhost:8888.
    //       // Be aware, the proxy should went through you running device,
    //       // not the host platform.
    //       return 'PROXY localhost:8888';
    //     };
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //     return client;
    //   },
    // );

    return mDio;
  }

  static InterceptorsWrapper interceptorsWrapper() {
    return InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      return handler.next(options); //continue
      // 如果你想完成请求并返回一些自定义数据，你可以resolve一个Response对象 `handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (response, handler) {
      // Do something with response data
      return handler.next(response); // continue
      // 如果你想终止请求并触发一个错误,你可以 reject 一个`DioError`对象,如`handler.reject(error)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onError: (DioException e, handler) {
      // Do something with response error

      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showWarnToast("当前登录已过期，请重新登录！");
          Future.delayed(const Duration(milliseconds: 1000), () {
            /// todo 跳转登录页面
          });
        } else if (e.response?.statusCode == 403) {
          showWarnToast("暂无权限访问，请联系管理员！");
        } else {
          showWarnToast("系统内部异常！");
        }
      }

      return handler.next(e); //continue
      // 如果你想完成请求并返回一些自定义数据，可以resolve 一个`Response`,如`handler.resolve(response)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义response.
    });
  }

  ///Get请求
  Future<BaseRes> getHttp<T>(String url, parameters, {loading = true}) async {
    return await getResponse<T>(url,
        method: GET, parameters: parameters, loading: loading);
  }

  Future<BaseRes> postHttp<T>(String url, parameters, {loading = true}) async {
    ///定义请求参数
    parameters = parameters ?? <String, dynamic>{};

    return await getResponse<T>(url,
        method: POST, parameters: parameters, loading: loading);
  }

  Future<BaseRes> putHttp<T>(String url, parameters, {loading = true}) async {
    ///定义请求参数
    parameters = parameters ?? <String, dynamic>{};

    return await getResponse<T>(url,
        method: PUT, parameters: parameters, loading: loading);
  }

  Future<BaseRes> deleteHttp<T>(String url, parameters,
      {loading = true}) async {
    ///定义请求参数
    parameters = parameters ?? <String, dynamic>{};
    return await getResponse<T>(url,
        method: DELETE, parameters: parameters, loading: loading);
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath, onReceiveProgress) async {
    Response? response;
    try {
      response = await dio?.download(urlPath, savePath,
          onReceiveProgress: onReceiveProgress);
    } on DioException catch (e) {
      formatError(e);
    }
    return response?.data;
  }

  Future<BaseRes> getResponse<T>(
    String url, {
    required String method,
    parameters,
    loading,
  }) async {
    //这里指定response自动转成map,不指定的话有可能是String类型
    Response<Map<String, dynamic>>? response;

    if (loading) {
      showWarnToast('loading...');
    }

    print("method: $method");
    print("parameters: $parameters");

    switch (method) {
      case GET:
        response = await dio?.get(url,
            queryParameters: parameters ?? <String, dynamic>{});
        break;
      case PUT:
        response = await dio?.put(url,
            queryParameters: parameters ?? <String, dynamic>{});
        break;
      case DELETE:
        response = await dio?.delete(url,
            queryParameters: parameters ?? <String, dynamic>{});
        break;
      default:
        response =
            await dio?.post(url, data: parameters ?? <String, dynamic>{});
        break;
    }

    print("response: $response");
    //200代表网络请求成功
    if (response?.statusCode == 200) {
      /// 将后台的data字段转成自己想要的数据/数据集,code根据后端实际返回进行判断访问结果
      BaseRes bean = BaseRes.fromJson(response?.data as Map<String, dynamic>);

      return bean;
    } else if (response?.statusCode == 401) {
      showWarnToast("当前登录已过期，请重新登录！");
      Future.delayed(const Duration(milliseconds: 1000), () {
        // todo
      });
    } else if (response?.statusCode == 403) {
      showWarnToast("暂无权限访问，请联系管理员！");
    } else {
      showWarnToast("系统内部异常！");
    }

    throw Exception('${response?.statusCode}+${response?.statusMessage}');
  }

  void formatError(DioException e) {
    print("e.message");
    print(e.message);
  }

  /*
   * 取消请求
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}



// // Entity类使用的是JsonToDartBeanAction生成
//  BaseRes res = await HttpHelper.instance?.getHttp(url, data ,loading: false);
//     if(res?.code == 200 && res?.data != null) {
//       state.userInfo = res!.data.obs;
//     }
