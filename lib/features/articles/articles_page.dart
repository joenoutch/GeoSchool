import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/articles_repository.dart';
import '../../widgets/app_error.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/section_title.dart';
import 'package:intl/intl.dart';

class ArticlesPage extends ConsumerWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(_articlesFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Actualités')),
      body: future.when(
        data: (articles) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SectionTitle(title: 'En vedette'),
            const SizedBox(height: 8),
            if (articles.isEmpty)
              const Text('Pas d’article trouvé.'),
            ...articles.map((a) => Card(
              child: ListTile(
                title: Text(a.title),
                subtitle: Text(a.excerpt ?? ''),
                trailing: Text(a.publishedAt != null ? DateFormat('dd/MM/yyyy').format(a.publishedAt!) : ''),
              ),
            )),
          ],
        ),
        loading: () => const AppLoader(),
        error: (e, _) => AppError(message: e.toString()),
      ),
    );
  }
}

final _articlesFutureProvider = FutureProvider((ref) => ref.read(articlesRepoProvider).fetchFeatured());
