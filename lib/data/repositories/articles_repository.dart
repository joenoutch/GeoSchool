import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/config.dart';
import '../../core/http_client.dart';
import '../models/article.dart';

final articlesRepoProvider = Provider<ArticlesRepository>((ref) => ArticlesRepository());

class ArticlesRepository {
  Future<List<Article>> fetchFeatured() async {
    try {
      final res = await dio.get(AppConfig.articlesPath, queryParameters: {'featured': 1});
      final data = res.data as List? ?? [];
      return data.map((e) => Article.fromJson(Map<String, dynamic>.from(e))).toList();
    } on DioException {
      // Fallback mock minimal
      return [
        Article(id: 1, title: 'Bienvenue sur GeoSchool', excerpt: 'Toutes les écoles à portée de main.'),
      ];
    }
  }
}
