import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cancha_model.dart';

class CanchaNotifier extends StateNotifier<List<Cancha>> {
  CanchaNotifier() : super([]);

  void agregarCancha(Cancha cancha) {
    state = [...state, cancha];
  }

  void eliminarCancha(String id) {
    state = state.where((cancha) => cancha.id != id).toList();
  }

  void actualizarDisponibilidad(String id, bool disponible) {
    state = state.map((cancha) {
      if (cancha.id == id) {
        return Cancha(
          id: cancha.id,
          nombre: cancha.nombre,
          descripcion: cancha.descripcion,
          disponible: disponible,
        );
      } else {
        return cancha;
      }
    }).toList();
  }
}

final canchaProvider = StateNotifierProvider<CanchaNotifier, List<Cancha>>((ref) {
  return CanchaNotifier();
});
