import 'package:flutter/material.dart';
import '../../widgets/section_title.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: const Text('GeoSchool'),
          backgroundColor: cs.surface,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              tooltip: 'Rechercher',
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Hero card
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [cs.primary, cs.secondary]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Trouvez l’établissement idéal.\nFiltrez par ville, type et explorez la carte.',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      FilledButton.tonal(
                        onPressed: () {},
                        style: FilledButton.styleFrom(backgroundColor: Colors.white),
                        child: Text('Commencer', style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const SectionTitle(title: 'Nouveaux établissements'),
                const SizedBox(height: 12),
                // Placeholder … (tu pourras injecter un ListView d’établissements populaires)
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 6,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (ctx, i) => Container(
                      width: 200,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: cs.outlineVariant),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Établissement ${i + 1}', style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          Text('Ville inconnue', style: TextStyle(color: cs.onSurfaceVariant)),
                          const Spacer(),
                          TextButton.icon(onPressed: () {}, icon: const Icon(Icons.chevron_right), label: const Text('Voir la fiche')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
