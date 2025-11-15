extends Node2D

@export var height:int
@export var weight:int

# clavijeros
var sep_cr_x = 115; # separacion entre clavijeros
var sep_cr_y = 97; # separacion entre clavijeros

const ENCHUFE = preload("uid://ca00e6afd76xl")
var _enchufes = []

func _ready() -> void:
	pass

func start():
	var h = 0
	var w = 0
	for i in height * weight: #clavijeros
		_enchufes.append(ENCHUFE.instantiate())
		self.add_child(_enchufes[i])
		
		if w == weight:
			h += 1
			w = 0
		
		_enchufes[i].position = Vector2(w * sep_cr_x, h * sep_cr_y) 
		w += 1

# comprueba si la solucion es correcta
func check() -> bool:
	for e in _enchufes:
		if not e.correcta():
			return false
	return true

# resetea todos los enchufes
func reset() :
	for e in _enchufes:
		e.reset()
