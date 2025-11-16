extends Node

# SEÑALES
signal totransition
signal transitioned
signal nextLevel # senial para avanzar el nivel
signal playLlamada(index) # Senial para reproducir llamada

# FLUJO
enum Scenes { MAIN_MENU, CLAVIJAS, MESA, PUERTA, CREDITS, INTRO, CONTEXT, NULL }
var to_scene : Scenes = 0
var current_scene : Scenes = 0

enum BombillaState { ENCENDIDA, APAGADA, BIEN, MAL }

var SceneManager

# para saber si se esta draggeando algo o no
var isDragging = false

# nivel actual
var nivel: int = 0
var niveles = [1,1,2,2,3,3]

var nPostits = 0;



func _poner_los_creditos()->void:
	current_scene = Scenes.CLAVIJAS
	to_scene = Scenes.CREDITS
	totransition.emit()
