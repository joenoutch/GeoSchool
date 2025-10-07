class Etablissement {
  final int id;
  final String slug;
  final String name;      // côté Laravel: nom
  final String? address;  // côté Laravel: adresse
  final String? city;     // villes.nom
  final double? lat;
  final double? lng;
  final String? type;     // ex: primaire, collège, lycée...

  Etablissement({
    required this.id,
    required this.slug,
    required this.name,
    this.address,
    this.city,
    this.lat,
    this.lng,
    this.type,
  });

  factory Etablissement.fromJson(Map<String, dynamic> j) => Etablissement(
    id: j['id'] as int,
    slug: j['slug'] as String? ?? '',
    name: j['name'] as String? ?? j['nom'] as String? ?? 'Établissement',
    address: j['address'] as String? ?? j['adresse'] as String?,
    city: j['city'] as String? ?? j['ville'] as String?,
    lat: (j['lat'] ?? j['latitude']) == null ? null : double.tryParse('${j['lat'] ?? j['latitude']}'),
    lng: (j['lng'] ?? j['longitude']) == null ? null : double.tryParse('${j['lng'] ?? j['longitude']}'),
    type: j['type'] as String?,
  );
}
