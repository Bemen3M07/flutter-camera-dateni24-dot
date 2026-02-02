import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ReproductorMusicaWidget extends StatefulWidget {
  const ReproductorMusicaWidget({Key? key}) : super(key: key);

  @override
  State<ReproductorMusicaWidget> createState() => _ReproductorMusicaWidgetState();
}

class _ReproductorMusicaWidgetState extends State<ReproductorMusicaWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _reproduciendo = false;
  Duration _duracion = Duration.zero;
  Duration _posicion = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((d) {
      setState(() { _duracion = d; });
    });
    _audioPlayer.onPositionChanged.listen((p) {
      setState(() { _posicion = p; });
    });
    _audioPlayer.onPlayerStateChanged.listen((s) {
      setState(() { _reproduciendo = s == PlayerState.playing; });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playPause() async {
    if (_reproduciendo) {
      await _audioPlayer.pause();
    } else {
      // Cambia la ruta por la de tu archivo de música en assets
      await _audioPlayer.play(AssetSource('musica.mp3'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(_reproduciendo ? Icons.pause : Icons.play_arrow, size: 48),
          onPressed: _playPause,
        ),
        Slider(
          value: _posicion.inSeconds.toDouble(),
          max: _duracion.inSeconds.toDouble() > 0 ? _duracion.inSeconds.toDouble() : 1,
          onChanged: (v) async {
            await _audioPlayer.seek(Duration(seconds: v.toInt()));
          },
        ),
        Text(
          '${_posicion.inMinutes}:${(_posicion.inSeconds%60).toString().padLeft(2,'0')} / '
          '${_duracion.inMinutes}:${(_duracion.inSeconds%60).toString().padLeft(2,'0')}',
        ),
        const SizedBox(height: 20),
        const Text('Reproduciendo: musica.mp3'),
      ],
    );
  }
}
