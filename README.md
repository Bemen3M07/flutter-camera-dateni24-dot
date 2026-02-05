

Ejercicio 0 (Estructura)
El prompt de ChatGPT me generó la base de la app con 3 pantallas: cámara, galería y reproductor de música. A partir de ahí, he ido añadiendo cosas como el uso de `Future`, `await`, y la gestión de estado para que todo funcione bien. El prompt original está aquí:

> Haz una app Flutter con 3 pantallas: una para hacer fotos (con cambio de cámara frontal/trasera y selector de resolución), una galería para ver las fotos, y un reproductor de música. Usa el plugin camera y muestra cómo usar availableCameras, CameraController, FutureBuilder, etc.

 Ejercicio 1 (Cámara)
- Se puede hacer una foto con la cámara del móvil.
- Sale un aviso (alert) cada vez que haces una foto, diciendo dónde se ha guardado.
- Puedes cambiar entre cámara frontal y trasera desde el menú de arriba.
- Puedes activar/desactivar el flash antes de hacer la foto.
- Puedes elegir la resolución de la cámara (baja, media, alta, etc.).
- Sale una miniatura de la última foto tomada.
- El título de la barra superior cambia según la pantalla (Cámara, Foto, Música).
- Abajo hay una barra de navegación con 3 botones: cámara, galería y multimedia.
- Todo lo de la cámara está agrupado en un menú arriba a la derecha.

Bug que encontré
Al cambiar de cámara, a veces se quedaba cargando. Lo he arreglado haciendo `await` al `dispose()` del controlador antes de crear el nuevo, y usando bien el `setState` para refrescar la UI. Así ya no se queda pillado.

 Ejercicio 2 (Imágenes)
- Las fotos que haces se guardan en el propio dispositivo, usando `path_provider` y `dart:io`.
- Se pueden ver todas las fotos guardadas en la galería de la app.
- (Opcional avanzado) Se podría exportar a la galería del móvil, pero aquí solo se guardan en la app.
- He buscado info sobre esto y he usado los plugins oficiales. 

 Ejercicio 3 (Reproductor de música)
- Hay un reproductor de música sencillo con 3 canciones .
- Puedes elegir la canción desde un menú desplegable.
- Hay botones de anterior, play/pause, siguiente y aleatorio.
- Puedes cambiar la velocidad de reproducción (0.5x, 1x, 1.5x, 2x).
- Sale el nombre de la canción que está sonando.
- Todo funciona con el plugin `audioplayers`.

 Cómo añadir más canciones
1. Añade el archivo mp3 a la carpeta `assets/`.
2. Decláralo en el `pubspec.yaml` bajo la sección de assets.
3. Añade el nombre y la ruta a la lista de canciones en el código del reproductor.

he usado todo el rato el
- Uso de `Future`, `await`, y gestión de estado con `setState` en toda la app.
- Plugins usados: `camera`, `path_provider`, `audioplayers`.
- El código está comentado y estructurado para que se entienda fácil.



