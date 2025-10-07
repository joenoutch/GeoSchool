import 'package:flutter/material.dart';
import 'router.dart';

class GeoSchoolApp extends StatelessWidget {
  const GeoSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF4F46E5);
    final light = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: seed));
    final dark  = ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark));

    return MaterialApp.router(
      title: 'GeoSchool',
      debugShowCheckedModeBanner: false,
      theme: light,
      darkTheme: dark,
      routerConfig: router,
    );
  }
}
