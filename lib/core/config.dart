class AppConfig {
  // Mets l’URL de ton Laravel ici (si tu testes en émulateur Android, utilise 10.0.2.2:8000)
  static const String baseUrl = 'http://127.0.0.1:8000';

  // Endpoints (prévois des routes API côté Laravel : /api/articles, /api/villes, /api/etablissements)
  static const String articlesPath = '/api/articles';
  static const String villesPath = '/api/villes';
  static const String etablissementsPath = '/api/etablissements';
}
