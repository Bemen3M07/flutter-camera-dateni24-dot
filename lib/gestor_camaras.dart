// Aquí se gestionarán las cámaras disponibles y el cambio de cámara
// Implementa la lógica usando el paquete camera

import 'package:camera/camera.dart';

class GestorCamaras {
  List<CameraDescription> camaras = [];
  int indiceActual = 0;

  Future<void> inicializar() async {
    camaras = await availableCameras();
  }

  CameraDescription get camaraActual => camaras[indiceActual];

  void cambiarCamara() {
    if (camaras.isNotEmpty) {
      indiceActual = (indiceActual + 1) % camaras.length;
    }
  }
}
