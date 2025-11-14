extends StaticBody2D

var _dropZone: int = 0
var _clavija: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = Color(Color.CHARTREUSE, 0.5) # Color y transparencia de dropzone.

func reset():
	_clavija.reset()
	_clavija = null

func insertar(clavija) -> void:
	_clavija = clavija

# Devuelve si esta ocupada y es correcta, si es correcta desocupa.
func correcta() ->bool:
	# Objetivo de la clavija es esta dropzone.
	if _clavija != null and _clavija.objetivo == _dropZone:
		reset()
		return true
	
	return false
