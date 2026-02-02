import 'package:flutter/material.dart';
import '../widgets/reproductor_musica_widget.dart';

class MusicaScreen extends StatelessWidget {
  const MusicaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Música')),
      body: const ReproductorMusicaWidget(),
    );
  }
}
