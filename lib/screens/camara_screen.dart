import 'package:flutter/material.dart';
import '../widgets/camara_widget.dart';

class CamaraScreen extends StatelessWidget {
  const CamaraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cámara')),
      body: const CamaraWidget(),
    );
  }
}
