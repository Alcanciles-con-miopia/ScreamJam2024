extends StaticBody2D

var dropZone: int = 0
var clavija: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.CHARTREUSE, 0.5) # Color y transparencia de dropzone.

func restart():
	clavija.desocupar()
	clavija = null

# Devuelve si esta ocupada y es correcta, si es correcta desocupa.
func correcta() ->bool:
	# Objetivo de la clavija es esta dropzone.
	if clavija != null and clavija.objetivo == dropZone:
		restart()
		return true
	
	return false
