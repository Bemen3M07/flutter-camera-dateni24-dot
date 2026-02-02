import 'dart:io';
import 'package:flutter/material.dart';
import '../gestor_galeria.dart';

class GaleriaWidget extends StatefulWidget {
  const GaleriaWidget({Key? key}) : super(key: key);

  @override
  State<GaleriaWidget> createState() => _GaleriaWidgetState();
}

class _GaleriaWidgetState extends State<GaleriaWidget> {
  final GestorGaleria _gestorGaleria = GestorGaleria();
  late Future<List<File>> _fotosFuture;

  @override
  void initState() {
    super.initState();
    _fotosFuture = _gestorGaleria.cargarFotos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<File>>(
      future: _fotosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final fotos = snapshot.data ?? [];
        if (fotos.isEmpty) {
          return const Center(child: Text('No hay fotos guardadas'));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: fotos.length,
          itemBuilder: (context, index) {
            return Image.file(fotos[index], fit: BoxFit.cover);
          },
        );
      },
    );
  }
}
