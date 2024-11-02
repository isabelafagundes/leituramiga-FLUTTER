import 'package:dio/dio.dart';
import 'package:projeto_leituramiga/infrastructure/service/auth/interceptor.dart' as leituramiga;

class HttpClient {
  static HttpClient? _instancia;
  Dio? _dio;

  HttpClient._();

  static HttpClient get instancia {
    _instancia ??= HttpClient._();
    _instancia!._dio ??= Dio();
    _instancia!._dio!.interceptors.add(leituramiga.Interceptor.instancia);
    return _instancia!;
  }

  Future<Response> post(String url, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      Response response = await _dio!.post(url, data: data, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(String url, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      Response response = await _dio!.get(url, data: data, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String url, {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    try {
      Response response = await _dio!.put(url, data: data, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String url, {Map<String, String>? headers}) async {
    try {
      Response response = await _dio!.delete(url, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> download(String url, String path, {Map<String, String>? headers}) async {
    try {
      Response response = await _dio!.download(url, path, options: Options(headers: headers));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
