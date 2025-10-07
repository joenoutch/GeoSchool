import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/http_client.dart';
import '../../core/auth_token.dart';

final authRepoProvider = Provider<AuthRepository>((ref) => AuthRepository());

class AuthRepository {
  Future<void> login(String email, String password) async {
    try {
      final res = await dio.post('/api/login', data: {'email': email, 'password': password});
      final token = res.data['token'] as String?;
      await AuthToken.instance.save(token);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Échec de connexion');
    }
  }

  Future<void> register(String name, String email, String password) async {
    try {
      final res = await dio.post('/api/register', data: {'name': name, 'email': email, 'password': password});
      final token = res.data['token'] as String?;
      await AuthToken.instance.save(token);
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Échec d’inscription');
    }
  }

  Future<void> logout() => AuthToken.instance.save(null);
}
