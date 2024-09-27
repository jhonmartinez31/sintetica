import 'package:flutter/material.dart';
// Asegúrate de que esta línea esté presente

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacto'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _lanzarWhatsApp,
          child: const Text('Enviar mensaje por WhatsApp'),
        ),
      ),
    );
  }

  void _lanzarWhatsApp() async {
    final url = Uri.parse('https://wa.me/123456789'); // Reemplaza con tu número de WhatsApp
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir WhatsApp.';
    }
  }
  
  launchUrl(Uri url) {}
  
  canLaunchUrl(Uri url) {}
}
