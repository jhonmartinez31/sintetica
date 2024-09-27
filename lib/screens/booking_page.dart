import 'package:flutter/material.dart';  
import 'package:intl/intl.dart';  
import 'package:shared_preferences/shared_preferences.dart';  
import 'dart:convert'; // Para jsonEncode y jsonDecode  
import '../models/booking_model.dart'; // Asegúrate de que la ruta sea correcta  

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});
  
  @override  
  _BookingPageState createState() => _BookingPageState();  
}  

class _BookingPageState extends State<BookingPage> {  
  final TextEditingController _nombreController = TextEditingController();  
  final TextEditingController _correoController = TextEditingController();  
  final TextEditingController _telefonoController = TextEditingController();  
  final TextEditingController _fechaController = TextEditingController();  
  final TextEditingController _horaInicioController = TextEditingController();  
  final TextEditingController _horaFinController = TextEditingController();  
  List<Reserva> _reservas = [];  

  @override  
  void initState() {  
    super.initState();  
    _loadReservas();  
  }  
  
  Future<void> _loadReservas() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();  
    final reservasString = prefs.getStringList('reservas') ?? [];  
    setState(() {  
      _reservas = reservasString.map((res) {  
        final Map<String, dynamic> map = Map<String, dynamic>.from(  
            jsonDecode(res) as Map);  
        return Reserva.fromJson(map);  
      }).toList();  
    });  
  }  

  Future<void> _saveReserva() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();  

    // Validar la entrada de datos  
    if (_nombreController.text.isEmpty ||  
        _correoController.text.isEmpty ||  
        _telefonoController.text.isEmpty ||  
        _fechaController.text.isEmpty ||  
        _horaInicioController.text.isEmpty ||  
        _horaFinController.text.isEmpty) {  
      _showErrorDialog('Por favor, completa todos los campos.');  
      return;  
    }  

    DateTime? fecha;  
    DateTime? horaInicio;  
    DateTime? horaFin;  

    try {  
      fecha = DateTime.parse(_fechaController.text);  
      horaInicio = DateTime.parse('${_fechaController.text} ${_horaInicioController.text}');  
      horaFin = DateTime.parse('${_fechaController.text} ${_horaFinController.text}');  
    } catch (e) {  
      _showErrorDialog('Formato de fecha y hora incorrecto. Usa el formato YYYY-MM-DD para la fecha y HH:MM para las horas.');  
      return;  
    }  

    final nuevaReserva = Reserva(  
      nombre: _nombreController.text,  
      correo: _correoController.text,  
      telefono: _telefonoController.text,  
      fecha: fecha,  
      horaInicio: horaInicio,  
      horaFin: horaFin,  
    );  

    if (_isAvailable(nuevaReserva)) {  
      setState(() {  
        _reservas.add(nuevaReserva);  
      });  
      await prefs.setStringList('reservas', _reservas.map((res) => jsonEncode(res.toMap())).toList());  
      _clearFields(); // Limpiar campos solo después de guardar  
    } else {  
      _showErrorDialog('La cancha ya está ocupada en el horario seleccionado.');  
    }  
  }  

  bool _isAvailable(Reserva nuevaReserva) {  
    return !_reservas.any((res) =>  
        res.fecha.isAtSameMomentAs(nuevaReserva.fecha) &&  
        !(nuevaReserva.horaFin.isBefore(res.horaInicio) || nuevaReserva.horaInicio.isAfter(res.horaFin)));  
  }  

  void _showErrorDialog(String message) {  
    showDialog(  
      context: context,  
      builder: (context) => AlertDialog(  
        title: const Text('Error'),  
        content: Text(message),  
        actions: [  
          TextButton(  
            onPressed: () => Navigator.of(context).pop(),  
            child: const Text('OK'),  
          ),  
        ],  
      ),  
    );  
  }  

  void _clearFields() {  
    _nombreController.clear();  
    _correoController.clear();  
    _telefonoController.clear();  
    _fechaController.clear();  
    _horaInicioController.clear();  
    _horaFinController.clear();  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Reservas'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          children: [  
            TextField(  
              controller: _nombreController,  
              decoration: const InputDecoration(labelText: 'Nombre'),  
            ),  
            TextField(  
              controller: _correoController,  
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),  
            ),  
            TextField(  
              controller: _telefonoController,  
              decoration: const InputDecoration(labelText: 'Número de Teléfono'),  
            ),  
            TextField(  
              controller: _fechaController,  
              decoration: const InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),  
              keyboardType: TextInputType.datetime,  
            ),  
            TextField(  
              controller: _horaInicioController,  
              decoration: const InputDecoration(labelText: 'Hora de Inicio (HH:MM)'),  
              keyboardType: TextInputType.datetime,  
            ),  
            TextField(  
              controller: _horaFinController,  
              decoration: const InputDecoration(labelText: 'Hora de Fin (HH:MM)'),  
              keyboardType: TextInputType.datetime,  
            ),  
            const SizedBox(height: 20),  
            ElevatedButton(  
              onPressed: _saveReserva,  
              child: const Text('Guardar Reserva'),  
            ),  
            const SizedBox(height: 20),  
            Expanded(  
              child: ListView.builder(  
                itemCount: _reservas.length,  
                itemBuilder: (context, index) {  
                  final reserva = _reservas[index];  
                  return ListTile(  
                    title: Text('Reserva de ${reserva.nombre}'),  
                    subtitle: Text('Fecha: ${DateFormat('dd/MM/yyyy').format(reserva.fecha)}, '  
                        'Hora: ${DateFormat('HH:mm').format(reserva.horaInicio)} - ${DateFormat('HH:mm').format(reserva.horaFin)}'),  
                  );  
                },  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  
}