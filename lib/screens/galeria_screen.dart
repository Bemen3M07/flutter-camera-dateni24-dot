import 'package:flutter/material.dart';
import '../widgets/galeria_widget.dart';

class GaleriaScreen extends StatelessWidget {
  const GaleriaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería')),
      body: const GaleriaWidget(),
    );
  }
}
