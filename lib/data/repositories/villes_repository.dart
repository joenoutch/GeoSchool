import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/config.dart';
import '../../core/http_client.dart';
import '../models/ville.dart';

final villesRepoProvider = Provider<VillesRepository>((ref) => VillesRepository());

class VillesRepository {
  Future<List<Ville>> fetchTop({int limit = 10}) async {
    try {
      final res = await dio.get(AppConfig.villesPath, queryParameters: {'limit': limit});
      final data = res.data as List? ?? [];
      return data.map((e) => Ville.fromJson(Map<String, dynamic>.from(e))).toList();
    } on DioException {
      return [];
    }
  }

  Future<List<Ville>> fetchAll() async {
    try {
      final res = await dio.get(AppConfig.villesPath);
      final data = res.data as List? ?? [];
      return data.map((e) => Ville.fromJson(Map<String, dynamic>.from(e))).toList();
    } on DioException {
      return [];
    }
  }
}
