extends Node2D

@export var cant : int = 5
@export var separacion:int = 100

var _bombillas = []
const BOMBILLA = preload("uid://b1xwb2nm08umh")

func _ready() -> void:
	pass

func start():
	for i in cant: #clavijas
		_bombillas.append(BOMBILLA.instantiate())
		self.add_child(_bombillas[i])
		
		_bombillas[i].position = Vector2(0, i * separacion) 
		_bombillas[i].reset()

func showDialogue(id) -> void:
	
