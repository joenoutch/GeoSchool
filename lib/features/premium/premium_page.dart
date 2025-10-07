import 'package:flutter/material.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Premium')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [cs.primary, cs.tertiary]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.white, size: 36),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Passez au Premium !\nComparateur intelligent, favoris illimités, zéro pub.',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ListTile(
              leading: const Icon(Icons.compare_arrows),
              title: const Text('Comparateur multi-critères'),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favoris illimités & alertes'),
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Brochures PDF & contenus exclusifs'),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                // TODO: Rediriger vers ton flux d’abonnement (webview ou deeplink)
              },
              child: const Text('Découvrir l’offre'),
            ),
          ],
        ),
      ),
    );
  }
}
