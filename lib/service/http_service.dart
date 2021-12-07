import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_mosque/config/locator.dart';
import 'package:smart_mosque/service/api_interceptor.dart';

@lazySingleton
class HttpService {
  // String base = 'http://192.168.90.188:8000/api';
  // String base = 'http://192.168.1.13:8000/api';
  String base = 'http://192.168.57.188:8000/api';

  Dio? dio = locator<ApiInterceptors>().dio;

  Future get(String url) async {
    try {
      url = base + url;
      final response =
      dio!.get(url, options: Options(headers: {"requiresToken": true}));
      return response;
    } catch (e) {
      exceptionHandler(e);
    }
  }
  Future download(String url, String savePath) async {
    try {
      // await Permission.storage.request();
      url = base + url;
      final response =
      dio!.download(url,savePath, options: Options(headers: {"requiresToken": true}));
      return response;
    } catch (e) {
      exceptionHandler(e);
    }
  }

  Future postLogin2(String url, var data) async {
    try {
      url = base + url;
      final response = await dio!.post(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }),
          data: data);
      return response;
    } catch (e) {
      exceptionHandler(e);
    }
  }

  Future post(String url, var data) async {
    try {
      url = base + url;
      final response = await dio!.post(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "requiresToken": true
          }),
          data: data);
      return response;
    }catch (e) {
      exceptionHandler(e);
    }
  }
  Future patch(String url, var data) async {
    try {
      url = base + url;
      final response = await dio!.patch(url,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "requiresToken": true
          }),
          data: data);
      return response;
    }catch (e) {
      exceptionHandler(e);
    }
  }
  void exceptionHandler(e){
    if(e.toString().contains('SocketException')){
      throw ('Koneksi internet anda tidak tersedia, silahkan coba lagi');
    }
    else if (e is DioError) {
      if (e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectTimeout) {
        throw ('Koneksi internet anda tidak tersedia, silahkan coba lagi');
      } else {
        if(e.response?.statusCode==500){
          throw ('Terjadi kesalahan server, silahkan coba lagi');
        }
        throw (e.response?.data['results'] ?? e.response?.data['message']);
      }
    }else{
      throw ('Koneksi internet anda tidak tersedia, silahkan coba lagi');
    }
  }
}
