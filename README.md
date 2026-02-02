
Exercici 0 (Estructura)
Feu un prompt de Chat GPT per fer una aplicació com aquesta. Incloeu el prompt al readme.md del projecte.

Bàsicament de context la app té que tenir 3 pantalles:
1. Una és de fer foto, pot canviar de càmera frontal i trasera, tindrà un gestor de càmeres amb un array de càmeres.
2. També tindrem una pestanya per veure les fotos.
3. L'última pantalla serà un reproductor de música.

La càmera tindrà una funció per canviar la resolució ex: medium, high, low, etc.
Hem d'utilitzar el future, await i demés.

availableCameras()
Funció del plugin de càmera que retorna un array de càmeres.
La primera càmera és la del davant (selfie).
La segona càmera és la del darrere.

CameraController: Controlador de la càmera.
S’inicialitza amb:
Una càmera de l’array
Resolució (ResolutionPreset)

Per iniciar la càmera:
initialize() Mètode de CameraController
CameraPreview Un cop inicialitzat el controlador, podem posar aquest widget la nostra pantalla
initialize() Mètode de CameraController
Retorna un Future amb la promesa d'inicialitzar la càmera.
El future té mètode getSnapshot, que retorna un AsyncSnapshot
L’AsyncSnapshot és una captura de l’estat del Future, amb els atributs:
data
hasData
connectionstate
errorr
haserror
FutureBuilder (És un widget)
Té un atribut que és el Future, per a “escoltar-lo”
Quan el future s’actualitza, el FutureBuilder li diu al Flutter que ha de repintar.
Té un altre atribut que és una lambda que rep com a paràmetre el context, i l’snapshot, i en aquesta lambda decidim cóm volem pintar el widget en funció de l’estat de l’snapshot del Future (Connection State)

CameraPreview és el widget que mostra el que veu el sensor de la càmera
Rep com a paràmetre el Controller

Cicle de vida
1. initState(): Demanar permisos i encendre la càmera.
2. build(): Mostrar la previsualització a l'usuari.
3. dispose(): Apagar el sensor per estalviar bateria.

⚠️ El que obris al 'init', tanca-ho al 'dispose'!

I per cert, la última pantalla serà un reproductor de música.

T'he posat imatges per més context encara.

L'últim és per Android Studio així que serà amb flutter run.

