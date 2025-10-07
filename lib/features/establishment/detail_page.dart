import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/repositories/establishments_repository.dart';
import '../../widgets/app_loader.dart';
import '../../widgets/app_error.dart';

class EstablishmentDetailPage extends ConsumerWidget {
  final String slug;
  const EstablishmentDetailPage({super.key, required this.slug});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fut = ref.watch(_detailProvider(slug));

    return Scaffold(
      appBar: AppBar(title: const Text('Établissement')),
      body: fut.when(
        loading: () => const AppLoader(),
        error: (e, _) => AppError(message: e.toString()),
        data: (e) {
          if (e == null) return const Center(child: Text('Introuvable'));
          final lat = e.lat, lng = e.lng;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(e.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text([e.city, e.address].where((s) => (s ?? '').isNotEmpty).join(' · ')),
              const SizedBox(height: 16),
              if (lat != null && lng != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    height: 220,
                    child: FlutterMap(
                      options: MapOptions(initialCenter: LatLng(lat, lng), initialZoom: 15),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.geoschool.app',
                          retinaMode: true,
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            width: 40,
                            height: 40,
                            point: LatLng(lat, lng),
                            builder: (_) => const Icon(Icons.location_on, color: Colors.red, size: 36),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              if (lat != null && lng != null)
                FilledButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                  icon: const Icon(Icons.directions),
                  label: const Text('Itinéraire'),
                ),
              const SizedBox(height: 24),
              const Text('À propos', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text('Type : ${e.type ?? "—"}'),
              // Tu peux enrichir ici (téléphone, site web, horaires, etc.)
            ],
          );
        },
      ),
    );
  }
}

final _detailProvider = FutureProvider.family((ref, String slug) {
  return ref.read(establishmentsRepoProvider).fetchBySlug(slug);
});
