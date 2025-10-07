import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../data/repositories/establishments_repository.dart';
import '../../widgets/app_error.dart';
import '../../widgets/app_loader.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(_mapFutureProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Carte')),
      body: future.when(
        data: (items) {
          final markers = items.where((e) => e.lat != null && e.lng != null).map((e) {
            return Marker(
              point: LatLng(e.lat!, e.lng!),
              width: 40,
              height: 40,
              builder: (_) => IconButton(
                icon: const Icon(Icons.location_on, color: Colors.red),
                onPressed: () {
				  showModalBottomSheet(
					context: context,
					showDragHandle: true,
					builder: (_) => ListTile(
					  title: Text(e.name),
					  subtitle: Text([e.city, e.address].where((s) => (s ?? '').isNotEmpty).join(' · ')),
					  trailing: const Icon(Icons.chevron_right),
					  onTap: () {
						Navigator.of(context).pop();
						// route vers la fiche
						Navigator.of(context).pushNamed('/e/${e.slug}');
					  },
					),
				  );
				}
              ),
            );
          }).toList();

          final center = markers.isNotEmpty ? markers.first.point : const LatLng(3.866, 11.516); // Yaoundé par défaut

          return FlutterMap(
            options: MapOptions(initialCenter: center, initialZoom: 12),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.geoschool.app',
                retinaMode: true,
              ),
              MarkerLayer(markers: markers),
              RichAttributionWidget(attributions: [
                TextSourceAttribution('© OpenStreetMap contributors'),
              ]),
            ],
          );
        },
        loading: () => const AppLoader(),
        error: (e, _) => AppError(message: e.toString()),
      ),
    );
  }
}

final _mapFutureProvider = FutureProvider((ref) => ref.read(establishmentsRepoProvider).search());
