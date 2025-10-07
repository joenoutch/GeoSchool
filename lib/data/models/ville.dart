class Ville {
  final int id;
  final String nom;
  final int etablissementsCount;

  Ville({required this.id, required this.nom, required this.etablissementsCount});

  factory Ville.fromJson(Map<String, dynamic> j) => Ville(
    id: j['id'] as int,
    nom: j['nom'] as String? ?? j['name'] as String? ?? 'Ville',
    etablissementsCount: j['etablissements_count'] as int? ?? j['schools_count'] as int? ?? 0,
  );
}
