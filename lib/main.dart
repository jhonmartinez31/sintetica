import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/booking_page.dart';
import 'screens/gallery_page.dart';
import 'screens/prices_page.dart';
import 'screens/contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cancha App',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/reservas': (context) => const BookingPage(),
        '/galeria': (context) => const GalleryPage(),
        '/precios': (context) => const PricesPage(),
        '/contacto': (context) => const ContactPage(),
      },
    );
  }
}
