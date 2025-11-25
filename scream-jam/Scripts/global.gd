extends Node

# SENYALES
signal totransition
signal transitioned
signal endedCall(int)
signal nextLevel # senial para avanzar el nivel
signal narrativeLoaded # Senial para marcar cuando se han cargado las narrativas
signal startTutorial
# FLUJO
enum Scenes { MAIN_MENU, CLAVIJAS, MESA, PUERTA, CREDITS, INTRO, CONTEXT, NULL }
var to_scene : Scenes = 0
var current_scene : Scenes = 0

enum BombillaState { ENCENDIDA, APAGADA, BIEN, MAL }

var SceneManager

# para saber si se esta draggeando algo o no
var isDragging = false

# nivel actual
var nivel: int = -1
var niveles = [1,1,2,2,3,3]

var nPostits = 0;

## Narrativas
var narrativas: Array = [] # Array para almacenar objetos Narrative

var enchufes: Array = [] # Array de enchufes para obtener su callable
var soluciones: Array = []

## Funcion para generar las narrativas del juego.
func generate_narrative() -> void:
	var persons = JsonParser.json_data["Persons"]
	var dialogos = JsonParser.json_data["Dialoges"]
	# Guardamos los personajes
	var characters: Array[NarrativeCharacter]
	for p in persons:
		# Settea nombre y color.
		var character = NarrativeCharacter.new(p["Name"], Color(p["Color"]["R"], p["Color"]["G"], p["Color"]["B"]))
		character.set_font(load(p["Font"]))
		# Recorrer cada emocion y sus sonidos.
		for emo_name in p["Sound"].keys():
			var emo_enum = NarrativeCharacter.Emotion[emo_name.to_upper()]
			var paths = p["Sound"][emo_name]
			# Por si hay varios sonidos para la emocion.
			if paths is Array:
				character.sounds[emo_enum] = paths.duplicate()
		characters.push_back(character)
	
	# Guardamos los dialogos.
	for narr_data in dialogos:
		var narrative = Narrative.new()
		var clavijero_esperado: int = narr_data["Clavijero"] # Obtener el enchufe objetivo.
		soluciones.append(clavijero_esperado)
		
		# Funcion lambda (Callable) para la condicion
		# Coge la funcion "correcta" dentro del enchufe esperado.
		var condition_lambda = Callable(enchufes[clavijero_esperado], "correcta")
		
		# Carga los textos.
		for blq in narr_data["Texts"]:
			var bloq = NarrativeBLock.new(characters[blq["Person"]], NarrativeCharacter.Emotion[blq["Emotion"].to_upper()], blq["Text"])
			if "@" in blq["Text"]:
				bloq.add_condition(condition_lambda)
				bloq.set_text(blq["Text"].replace("@", ""))
			narrative.add_block(bloq)
		
		narrativas.push_back(narrative)
	
	narrativeLoaded.emit()

func _poner_los_creditos()->void:
	current_scene = Scenes.CLAVIJAS
	to_scene = Scenes.CREDITS
	totransition.emit()
