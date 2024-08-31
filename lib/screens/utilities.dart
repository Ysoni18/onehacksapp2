import 'package:flutter/material.dart';

class UtilitiesPage extends StatelessWidget {
  const UtilitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utilities'),
      ),
      body: const Center(
        child: Text('Groceries Details Here'),
      ),
    );
  }
}
