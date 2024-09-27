import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galería'),
      ),
      body: const Center(
        child: Text('Aquí irán las imágenes de la cancha.'),
      ),
    );
  }
}
