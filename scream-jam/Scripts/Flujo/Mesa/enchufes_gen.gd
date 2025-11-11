extends Node2D

@export var height:int
@export var weight:int

# clavijeros
var off_cr_x = 723; # offset clavijeros
var off_cr_y = 246; # aka posicion incial del primer clavijero
var sep_cr_x = 115; # separacion entre clavijeros
var sep_cr_y = 97; # separacion entre clavijeros

const ENCHUFE = preload("uid://ca00e6afd76xl")
var _clavijeros = []

func _ready() -> void:
	var h = 0
	var w = 0
	for i in height * weight: #clavijeros
		_clavijeros[i] = ENCHUFE.instance()
		self.add_child(_clavijeros[i])
		
		if w == weight:
			h += 1
			w = 0
		
		_clavijeros[i].position = Vector2(w * sep_cr_x + off_cr_x, h * sep_cr_y + off_cr_y) 
		w += 1
# comprueba si la solucion es correcta
func check() -> bool:
	for c in _clavijeros:
		if not c.correcta():
			return false
	return true

# resetea todos los enchufes
func reset() :
	for c in _clavijeros:
		c.reset()
