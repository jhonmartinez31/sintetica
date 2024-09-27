import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Cancha de Deportes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto', // Cambia esto por una fuente más llamativa si lo deseas
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.pushNamed(context, '/reservas');
            },
          ),
          IconButton(
            icon: const Icon(Icons.price_change),
            onPressed: () {
              Navigator.pushNamed(context, '/precios');
            },
          ),
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: () {
              Navigator.pushNamed(context, '/galeria');
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido a nuestra cancha de deportes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto', // Cambia esto por una fuente más llamativa si lo deseas
              ),
            ),
            // Puedes agregar más widgets aquí para la presentación de la cancha
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _lanzarWhatsApp,
        backgroundColor: Colors.green,
        child: const Icon(Icons.chat),
      ),
    );
  }

  void _lanzarWhatsApp() async {
    const url = 'https://wa.me/123456789'; // Reemplaza con tu número de WhatsApp
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir WhatsApp.';
    }
  }
  
  launch(String url) {}
  
  canLaunch(String url) {}
}
