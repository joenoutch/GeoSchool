import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/establishments_repository.dart';
import '../../data/repositories/villes_repository.dart';
import '../../data/models/etablissement.dart';

class DirectoryPage extends ConsumerStatefulWidget {
  const DirectoryPage({super.key});
  @override
  ConsumerState<DirectoryPage> createState() => _DirectoryPageState();
}

class _DirectoryFilters {
  String q = '';
  int? villeId;
  String? type;
}

class _DirectoryPageState extends ConsumerState<DirectoryPage> {
  final filters = _DirectoryFilters();
  final items = <Etablissement>[];
  final ctrl = ScrollController();
  bool loading = false;
  bool end = false;
  int page = 1;
  final perPage = 20;

  @override
  void initState() {
    super.initState();
    _load(reset: true);
    ctrl.addListener(() {
      if (!loading && !end && ctrl.position.pixels > ctrl.position.maxScrollExtent - 400) {
        _load();
      }
    });
  }

  Future<void> _load({bool reset = false}) async {
    setState(() => loading = true);
    if (reset) { page = 1; end = false; items.clear(); }
    final newItems = await ref.read(establishmentsRepoProvider).search(
      q: filters.q.isEmpty ? null : filters.q,
      villeId: filters.villeId,
      type: filters.type,
      // côté API: page/per_page si dispo
    );
    // Si l’API ne pagine pas encore : simule un « chunk »
    final chunk = newItems.skip((page - 1) * perPage).take(perPage).toList();
    if (chunk.isEmpty || chunk.length < perPage) end = true;
    items.addAll(chunk);
    page++;
    setState(() => loading = false);
  }

  void _applyFilters() => _load(reset: true);

  @override
  Widget build(BuildContext context) {
    final villesFuture = ref.watch(_villesFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Annuaire')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(hintText: 'Rechercher une école…', prefixIcon: Icon(Icons.search)),
                  onSubmitted: (v) { filters.q = v; _applyFilters(); },
                ),
              ),
              const SizedBox(width: 8),
              villesFuture.when(
                data: (villes) => DropdownButton<int?>(
                  value: filters.villeId,
                  hint: const Text('Ville'),
                  onChanged: (id) { filters.villeId = id; _applyFilters(); },
                  items: [
                    const DropdownMenuItem(value: null, child: Text('Toutes')),
                    ...villes.map((v) => DropdownMenuItem(value: v.id, child: Text('${v.nom} (${v.etablissementsCount})')))
                  ],
                ),
                loading: () => const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                error: (_, __) => const Icon(Icons.error, color: Colors.red),
              ),
              const SizedBox(width: 8),
              DropdownButton<String?>(
                value: filters.type ?? 'Tous',
                onChanged: (val) { filters.type = (val == 'Tous') ? null : val; _applyFilters(); },
                items: const [
                  DropdownMenuItem(value: 'Tous', child: Text('Tous')),
                  DropdownMenuItem(value: 'Maternelle', child: Text('Maternelle')),
                  DropdownMenuItem(value: 'Primaire', child: Text('Primaire')),
                  DropdownMenuItem(value: 'Collège', child: Text('Collège')),
                  DropdownMenuItem(value: 'Lycée', child: Text('Lycée')),
                  DropdownMenuItem(value: 'Université', child: Text('Université')),
                ],
              ),
            ]),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _load(reset: true),
              child: ListView.separated(
                controller: ctrl,
                itemCount: items.length + 1,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (ctx, i) {
                  if (i == items.length) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: end
                          ? const Text('Fin de la liste')
                          : const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                      ),
                    );
                  }
                  final e = items[i];
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.school)),
                    title: Text(e.name),
                    subtitle: Text([e.city, e.address].where((s) => (s ?? '').isNotEmpty).join(' · ')),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/e/${e.slug}'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final _villesFutureProvider = FutureProvider((ref) => ref.read(villesRepoProvider).fetchAll());
