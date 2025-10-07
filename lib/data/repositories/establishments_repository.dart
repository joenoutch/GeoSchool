import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/config.dart';
import '../../core/http_client.dart';
import '../models/etablissement.dart';

final establishmentsRepoProvider = Provider<EstablishmentsRepository>((ref) => EstablishmentsRepository());

class EstablishmentsRepository {
  Future<List<Etablissement>> search({String? q, int? villeId, String? type}) async {
    try {
      final res = await dio.get(AppConfig.etablissementsPath, queryParameters: {
        if (q != null && q.isNotEmpty) 'q': q,
        if (villeId != null) 'ville_id': villeId,
        if (type != null && type.isNotEmpty) 'type': type,
        'limit': 50,
      });
      final data = res.data as List? ?? [];
      return data.map((e) => Etablissement.fromJson(Map<String, dynamic>.from(e))).toList();
    } on DioException {
      // Fallback mock
      return [
        Etablissement(id: 1, slug: 'demo-1', name: 'Lycée Demo', city: 'Douala', address: 'Quartier Bonapriso', lat: 4.044, lng: 9.704),
        Etablissement(id: 2, slug: 'demo-2', name: 'Collège Test', city: 'Yaoundé', address: 'Bastos', lat: 3.866, lng: 11.516),
      ];
    }
  }
  
    Future<Etablissement?> fetchBySlug(String slug) async {
    try {
      final res = await dio.get('${AppConfig.etablissementsPath}/$slug');
      final j = Map<String, dynamic>.from(res.data);
      return Etablissement.fromJson(j);
    } on DioException {
      return null;
    }
  }

}
