import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String message;
  const AppError({super.key, required this.message});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(message, style: const TextStyle(color: Colors.red)),
    ),
  );
}
