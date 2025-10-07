import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

// --- Push (optionnel) ---
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'router.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBg(RemoteMessage msg) async {
  // Traitement background si besoin
}

Future<void> _initPush() async {
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseBg);
  await FirebaseMessaging.instance.requestPermission();
  // Ouvrir la fiche si l’app est en background et qu’on clique sur la notif
  FirebaseMessaging.onMessageOpenedApp.listen((m) {
    final slug = m.data['slug'];
    if (slug != null) router.push('/e/$slug');
  });
  // Si l’app est TUÉE et qu’on l’ouvre depuis la notif
  final initial = await FirebaseMessaging.instance.getInitialMessage();
  if (initial != null && initial.data['slug'] != null) {
    router.push('/e/${initial.data['slug']}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Commente si tu n’as pas encore configuré Firebase
  try { await _initPush(); } catch (_) {}
  runApp(const ProviderScope(child: GeoSchoolApp()));
}
