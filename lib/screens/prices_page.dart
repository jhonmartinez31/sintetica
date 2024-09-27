import 'package:flutter/material.dart';

class PricesPage extends StatelessWidget {
  const PricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Precios'),
      ),
      body: const Center(
        child: Text('Aquí se mostrarán los precios de las reservas.'),
      ),
    );
  }
}
