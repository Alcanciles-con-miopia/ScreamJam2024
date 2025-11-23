extends Node2D

@export var height:int
@export var weight:int

# clavijeros
## Separacion X entre enchufes
@export var sep_cr_x = 115; 
## Separacion Y entre enchufes
@export var sep_cr_y = 97; 

const ENCHUFE = preload("uid://ca00e6afd76xl")
var _enchufes = []

func _ready() -> void:
	pass

func start():
	for h in height: #clavijeros
		for w in weight:
			_enchufes.append(ENCHUFE.instantiate())
			self.add_child(_enchufes[h*weight +w])
			
			_enchufes[h*weight +w].position = Vector2(w * sep_cr_x, h * sep_cr_y) 
			_enchufes[h*weight +w]._id = h*weight +w
			w += 1
	
	Global.enchufes = _enchufes

# comprueba si la solucion es correcta
func check() -> bool:
	var correcta = true
	for e in _enchufes:
		if not e.correcta():
			correcta = false
	return correcta

# resetea todos los enchufes
func reset() :
	for e in _enchufes:
		e.reset()
