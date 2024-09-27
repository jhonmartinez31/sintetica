// models/booking_model.dart

class Reserva {
  final String nombre;
  final String correo;
  final String telefono;
  final DateTime fecha;
  final DateTime horaInicio;
  final DateTime horaFin;

  Reserva({
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
      'fecha': fecha.toIso8601String(),
      'horaInicio': horaInicio.toIso8601String(),
      'horaFin': horaFin.toIso8601String(),
    };
  }

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      nombre: json['nombre'],
      correo: json['correo'],
      telefono: json['telefono'],
      fecha: DateTime.parse(json['fecha']),
      horaInicio: DateTime.parse(json['horaInicio']),
      horaFin: DateTime.parse(json['horaFin']),
    );
  }
}
