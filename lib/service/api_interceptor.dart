import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ApiInterceptors {
  Dio? dio;

  ApiInterceptors() {
    print('construct');
    dio = new Dio(BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 20000,
      contentType: "application/json;charset=utf-8",
    ));
    dio?.interceptors.add(InterceptorsWrapper(
        onRequest:
            (RequestOptions options,RequestInterceptorHandler handler) =>
            requestInterceptor(options,handler),
        onError: errorInterceptor,
        onResponse: (Response res, handler){
          print(res.statusCode);
          print(res.data);
          return handler.next(res);
        }));

    // dioCacheManager = DioCacheManager(CacheConfig());
    // dio.interceptors.add(dioCacheManager.interceptor);
  }
  dynamic errorInterceptor(
      DioError error, ErrorInterceptorHandler handler) async {
    print("<-- ${error.message}");
    print("${error.response != null ? error.response?.data : 'Unknown Error'}");
    print("<-- End error");
    return handler.next(error);
  }

  dynamic requestInterceptor(RequestOptions options, RequestInterceptorHandler handler) async {
    print('on request');
    print(options.path);
    print(options.headers.containsKey("requiresToken"));
    if (options.headers.containsKey("requiresToken")) {
      //remove the auxiliary header
      options.headers.remove("requiresToken");

      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString("token");
      print(token);
//       print(token);
      options.headers.addAll({"Authorization": "Bearer $token"});

    }
    return handler.next(options);
  }

  // Future<bool> deleteCacheByKey(String key) async{
  //   print('delete cache');
  //   bool deleteCache =  await dioCacheManager.delete(key,requestMethod: 'GET');
  //   return deleteCache;
  // }
  //
  // Future<bool> deleteAllCache() async{
  //   print('delete cache');
  //   bool deleteCache = await dioCacheManager.clearAll();
  //   return deleteCache;
  // }

  Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 5));
      bool res;
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('ok internet');
        res = true;
      } else {
        res = false;
      }
      return res;
    } on SocketException catch (_) {
      print('no connection');
      return false;
    }
  }
}
