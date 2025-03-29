import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../routing/app_router.dart'; // Import for route names

class NotFoundScreen extends StatelessWidget {
  final String? message;
  const NotFoundScreen({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
              const SizedBox(height: 20),
              Text(
                message ?? 'Sorry, the page or resource you requested could not be found.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.home_outlined),
                label: const Text('Go to Home'),
                onPressed: () => context.goNamed(AppRoute.home.name), // Navigate back home
              ),
            ],
          ),
        ),
      ),
    );
  }
}