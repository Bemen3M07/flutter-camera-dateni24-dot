
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


---

# Exercici 1 (Càmera) - Funcionalitats implementades

## Resum de funcionalitats afegides

- **Captura d’imatges:** L’usuari pot capturar imatges amb la càmera del dispositiu.
- **Alerta de foto guardada:** Cada vegada que es fa una foto, es mostra un avís (AlertDialog) amb la ruta on s’ha emmagatzemat la imatge.
- **Canvi de càmera:** Es pot canviar entre càmera frontal i trasera des d’un menú superior.
- **Control de flash:** Es pot activar o desactivar el flash des del menú superior abans de fer la foto.
- **Canvi de resolució:** Es pot seleccionar la resolució de la càmera (baixa, mitjana, alta, etc.) des del menú.
- **Miniatura de l’última foto:** Es mostra la miniatura de l’última foto presa a la pantalla de la càmera.
- **Navigation bar superior:** El títol de la barra superior canvia segons la pantalla (Càmera, Foto, Música).
- **Barra inferior de navegació:** Hi ha una BottomNavigationBar amb tres botons: càmera, galeria (foto) i multimedia.
- **Layout clar i funcional:** Les opcions de càmera estan agrupades en un menú a la part superior dreta (PopupMenuButton).


## Corrección de bug: cambio de cámara

- **Problema detectado:** Al canviar de càmera frontal a trasera (o viceversa), la previsualització es quedava carregant de forma infinita.
- **Solució aplicada:**
	- Ara, abans de crear el nou controlador de càmera, es fa `await` al `dispose()` del controlador anterior per assegurar que es tanca correctament.
	- La creació i inicialització del nou controlador és asíncrona i es gestiona l'estat amb `setState` per garantir que la UI es refresca correctament.
	- Això evita que la càmera es quedi bloquejada i permet canviar de càmera de manera fluida i fiable.

## Estructura de pantalles

- **Pantalla de càmera:**
	- Previsualització de la càmera.
	- Menú superior amb opcions: canviar càmera, activar/desactivar flash, seleccionar resolució.
	- Botó per fer foto.
	- Miniatura de l’última foto presa.
	- Alerta amb la ruta de la foto després de capturar-la.
- **Pantalla de galeria:**
	- Mostra totes les fotos guardades.
- **Pantalla de música:**
	- Reproductor d’àudio senzill.

## Notes tècniques

- S’utilitza el plugin oficial `camera` per accedir a la càmera i controlar el flash.
- S’utilitza `path_provider` i `dart:io` per guardar i carregar fotos.
- S’utilitza `FutureBuilder` i gestió d’estat amb `setState` per actualitzar la UI.
- El codi està documentat i estructurat per facilitar la comprensió i manteniment.

---

L'últim és per Android Studio així que serà amb flutter run.

