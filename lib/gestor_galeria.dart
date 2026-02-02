// Aquí se gestionarán las fotos tomadas y se podrán guardar/cargar desde almacenamiento
// Implementa la lógica usando path_provider y File

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GestorGaleria {
  Future<String> get _directorioFotos async {
    final dir = await getApplicationDocumentsDirectory();
    final path = '${dir.path}/fotos';
    final d = Directory(path);
    if (!await d.exists()) {
      await d.create(recursive: true);
    }
    return path;
  }

  Future<void> guardarFoto(List<int> bytes) async {
    final path = await _directorioFotos;
    final nombre = DateTime.now().millisecondsSinceEpoch.toString();
    final archivo = File('$path/$nombre.jpg');
    await archivo.writeAsBytes(bytes);
  }

  Future<List<File>> cargarFotos() async {
    final path = await _directorioFotos;
    final dir = Directory(path);
    final archivos = dir.listSync().whereType<File>().toList();
    archivos.sort((a, b) => b.path.compareTo(a.path));
    return archivos;
  }
}
