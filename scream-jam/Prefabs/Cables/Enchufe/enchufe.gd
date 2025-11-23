extends StaticBody2D

var _id: int = 0
var _clavija: Node2D

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
	if _clavija == null: return false
	print("CHECK: " + str(_clavija.objetivo) + "/" + str(_id))
	if _clavija.objetivo == _id:
		_clavija.check(true)
		return true
	_clavija.check(false)
	return false
