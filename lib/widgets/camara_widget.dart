import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../gestor_camaras.dart';
import '../gestor_galeria.dart';

class CamaraWidget extends StatefulWidget {
  const CamaraWidget({Key? key}) : super(key: key);

  @override
  State<CamaraWidget> createState() => _CamaraWidgetState();
}

class _CamaraWidgetState extends State<CamaraWidget> {
  final GestorCamaras _gestorCamaras = GestorCamaras();
  CameraController? _controlador;
  ResolutionPreset _resolucion = ResolutionPreset.medium;
  bool _iniciando = true;
  String? _error;
  final GestorGaleria _gestorGaleria = GestorGaleria();

  @override
  void initState() {
    super.initState();
    _inicializarCamaras();
  }

  Future<void> _inicializarCamaras() async {
    setState(() { _iniciando = true; _error = null; });
    try {
      await _gestorCamaras.inicializar();
      _crearControlador();
    } catch (e) {
      setState(() { _error = e.toString(); _iniciando = false; });
    }
  }

  Future<void> _crearControlador() async {
    setState(() { _iniciando = true; });
    try {
      await _controlador?.dispose();
      _controlador = CameraController(
        _gestorCamaras.camaraActual,
        _resolucion,
        enableAudio: false,
      );
      await _controlador!.initialize();
      if (mounted) setState(() { _iniciando = false; });
    } catch (e) {
      setState(() { _error = e.toString(); _iniciando = false; });
    }
  }

  Future<void> _cambiarCamara() async {
    setState(() { _iniciando = true; });
    _gestorCamaras.cambiarCamara();
    await _crearControlador();
  }

  Future<void> _cambiarResolucion(ResolutionPreset resol) async {
    setState(() {
      _resolucion = resol;
      _iniciando = true;
    });
    await _crearControlador();
  }

  Future<void> _tomarFoto() async {
    if (_controlador == null || !_controlador!.value.isInitialized) return;
    try {
      final foto = await _controlador!.takePicture();
      final bytes = await foto.readAsBytes();
      await _gestorGaleria.guardarFoto(bytes);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto guardada en la galería')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al tomar foto: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _controlador?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(child: Text('Error: $_error'));
    }
    if (_iniciando || _controlador == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Expanded(
          child: CameraPreview(_controlador!),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              onPressed: () {
                _cambiarCamara();
              },
              tooltip: 'Cambiar cámara',
            ),
            IconButton(
              icon: const Icon(Icons.camera),
              onPressed: _tomarFoto,
              tooltip: 'Tomar foto',
            ),
            DropdownButton<ResolutionPreset>(
              value: _resolucion,
              items: const [
                DropdownMenuItem(
                  value: ResolutionPreset.low,
                  child: Text('Baja'),
                ),
                DropdownMenuItem(
                  value: ResolutionPreset.medium,
                  child: Text('Media'),
                ),
                DropdownMenuItem(
                  value: ResolutionPreset.high,
                  child: Text('Alta'),
                ),
                DropdownMenuItem(
                  value: ResolutionPreset.ultraHigh,
                  child: Text('Ultra'),
                ),
                DropdownMenuItem(
                  value: ResolutionPreset.max,
                  child: Text('Máxima'),
                ),
              ],
              onChanged: (res) {
                if (res != null) {
                  _cambiarResolucion(res);
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
