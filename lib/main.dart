import 'package:flutter/material.dart'; // Flutter UI
import 'screens/camara_screen.dart';
import 'screens/galeria_screen.dart';
import 'screens/musica_screen.dart';

void main() {
  runApp(const MiApp());
}

// App principal
class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Multimedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Pantalla con la barra inferior y navegación
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indiceActual = 0;
  // Lista de pantallas: cámara, galería, música
  final List<Widget> _pantallas = const [
    CamaraScreen(),
    GaleriaScreen(),
    MusicaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cambia de pantalla según el botón pulsado
      body: _pantallas[_indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceActual,
        onTap: (index) {
          setState(() {
            _indiceActual = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Cámara',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library),
            label: 'Galería',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Música',
          ),
        ],
      ),
    );
  }
}
