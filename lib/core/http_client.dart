import 'package:dio/dio.dart';
import 'config.dart';
import 'auth_token.dart';

final dio = Dio(BaseOptions(
  baseUrl: AppConfig.baseUrl,
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 15),
))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Ajoute le token si présent
      final t = AuthToken.instance.token;
      if (t != null && t.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $t';
      }
      return handler.next(options);
    },
  ))
  ..interceptors.add(LogInterceptor(responseBody: false));
