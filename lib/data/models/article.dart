class Article {
  final int id;
  final String title;
  final String? imageUrl;
  final String? excerpt;
  final DateTime? publishedAt;

  Article({
    required this.id,
    required this.title,
    this.imageUrl,
    this.excerpt,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> j) => Article(
    id: j['id'] as int,
    title: j['title'] as String? ?? j['titre'] as String? ?? 'Article',
    imageUrl: j['image_url'] as String? ?? j['image'] as String?,
    excerpt: j['excerpt'] as String? ?? j['resume'] as String?,
    publishedAt: j['published_at'] != null ? DateTime.tryParse(j['published_at']) : null,
  );
}
