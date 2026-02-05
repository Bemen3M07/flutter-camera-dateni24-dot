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
  double _velocidad = 1.0;
  int _cancionActual = 0;
  bool _aleatorio = false;

  final List<Map<String, String>> _canciones = [
    {'nombre': 'Canción 1', 'archivo': 'assets/canco1.mp3'},
    {'nombre': 'Canción 2', 'archivo': 'assets/canco2.mp3'},
    {'nombre': 'Canción 3', 'archivo': 'assets/canco3.mp3'},
  ];

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
    _audioPlayer.onPlayerComplete.listen((event) {
      _siguienteCancion(auto: true);
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
      await _audioPlayer.setPlaybackRate(_velocidad);
      await _audioPlayer.play(AssetSource(_canciones[_cancionActual]['archivo']!.replaceFirst('assets/', '')));
    }
  }

  Future<void> _cambiarCancion(int index) async {
    setState(() {
      _cancionActual = index;
      _posicion = Duration.zero;
      _duracion = Duration.zero;
    });
    await _audioPlayer.stop();
    await _audioPlayer.setPlaybackRate(_velocidad);
    await _audioPlayer.play(AssetSource(_canciones[_cancionActual]['archivo']!.replaceFirst('assets/', '')));
  }

  Future<void> _siguienteCancion({bool auto = false}) async {
    int siguiente;
    if (_aleatorio) {
      siguiente = _cancionActual;
      while (siguiente == _cancionActual && _canciones.length > 1) {
        siguiente = (List.generate(_canciones.length, (i) => i)..shuffle()).first;
      }
    } else {
      siguiente = (_cancionActual + 1) % _canciones.length;
    }
    await _cambiarCancion(siguiente);
    if (!auto) await _audioPlayer.resume();
  }

  Future<void> _anteriorCancion() async {
    int anterior = (_cancionActual - 1 + _canciones.length) % _canciones.length;
    await _cambiarCancion(anterior);
    await _audioPlayer.resume();
  }

  Future<void> _cambiarVelocidad(double v) async {
    setState(() { _velocidad = v; });
    await _audioPlayer.setPlaybackRate(_velocidad);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Reproductor de música', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        DropdownButton<int>(
          value: _cancionActual,
          items: List.generate(_canciones.length, (i) => DropdownMenuItem(
            value: i,
            child: Text(_canciones[i]['nombre']!),
          )),
          onChanged: (i) async {
            if (i != null) await _cambiarCancion(i);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: _anteriorCancion,
            ),
            IconButton(
              icon: Icon(_reproduciendo ? Icons.pause : Icons.play_arrow, size: 48),
              onPressed: _playPause,
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: _siguienteCancion,
            ),
            IconButton(
              icon: Icon(_aleatorio ? Icons.shuffle_on : Icons.shuffle),
              tooltip: 'Aleatorio',
              onPressed: () {
                setState(() { _aleatorio = !_aleatorio; });
              },
            ),
          ],
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Velocidad:'),
            DropdownButton<double>(
              value: _velocidad,
              items: [0.5, 1.0, 1.5, 2.0].map((v) => DropdownMenuItem(
                value: v,
                child: Text('${v}x'),
              )).toList(),
              onChanged: (v) async {
                if (v != null) await _cambiarVelocidad(v);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Reproduciendo: ${_canciones[_cancionActual]['nombre']}'),
      ],
    );
  }
}
