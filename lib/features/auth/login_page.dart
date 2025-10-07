import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/auth_repository.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final email = TextEditingController();
  final pwd = TextEditingController();
  bool loading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Se connecter')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: email, decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 10),
          TextField(controller: pwd, decoration: const InputDecoration(labelText: 'Mot de passe'), obscureText: true),
          const SizedBox(height: 16),
          if (error != null) Text(error!, style: const TextStyle(color: Colors.red)),
          const SizedBox(height: 6),
          FilledButton(
            onPressed: loading ? null : () async {
              setState(() { loading = true; error = null; });
              try {
                await ref.read(authRepoProvider).login(email.text, pwd.text);
                if (mounted) Navigator.of(context).pop();
              } catch (e) {
                setState(() => error = e.toString());
              } finally {
                if (mounted) setState(() => loading = false);
              }
            },
            child: loading ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Connexion'),
          ),
          const SizedBox(height: 20),
          TextButton(onPressed: () => Navigator.of(context).pushNamed('/register'), child: const Text('Créer un compte')),
        ]),
      ),
    );
  }
}
