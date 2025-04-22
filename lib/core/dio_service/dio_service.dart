import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_quote_generator/core/dio_service/dio_response.dart';
import 'package:random_quote_generator/core/error/app_error_catching.dart';
import 'package:random_quote_generator/env/env.dart';

abstract class DioService {
  Future<DioResponse> getApi(String endpoint);

  Future<DioResponse> postApi(String endpoint, Map<String, dynamic> data);
}

class DioServiceImpl extends DioService {
  final Dio _dio = Dio();

  DioServiceImpl() {
    final baseUrl = Env.baseUrl;
    _dio.options = BaseOptions(
      baseUrl: baseUrl, // Replace with your base URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Dio get dio => _dio;

  @override
  Future<DioResponse> getApi(String endpoint) async {
    // try {
    //   final response = await _dio.get(endpoint);
    //   final dioResponse = DioResponse.fromJson({
    //     'data': response.data,
    //     'statusCode': response.statusCode,
    //     'statusMessage': response.statusMessage,
    //   });
    //   return dioResponse;
    // } catch (e) {
    //   rethrow;
    // }
    throw Exception("Calling getApi method is not implemented yet.");
  }

  @override
  Future<DioResponse> postApi(String endpoint, Map<String, dynamic> data) {
    // TODO: implement postApi
    throw UnimplementedError();
  }
}

final dioServiceProvider = Provider<DioService>((_) {
  final dioService = DioServiceImpl();
  return dioService;
});
