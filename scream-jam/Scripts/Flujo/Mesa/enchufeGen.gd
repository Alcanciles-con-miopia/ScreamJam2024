extends Node2D

@export var height:int
@export var weight:int

# clavijas
var off_cs_x = 722; # offset clavijas
var off_cs_y = 258; # aka posicion incial de la primera clavija
var sep_cs_x = 78; # separacion entre clavijas

func _ready() -> void:
	var h = 0
	var w = 0
	for i in height * weight: #clavijeros
		var enchufe = load("res://Scenes/Cables/DropZone.tscn").instantiate()
		self.add_child(enchufe)
		
		if w == weight:
			h += 1
			w = 0
		
		enchufe.position = Vector2(w * sep_cr_x + off_cr_x, h * sep_cr_y + off_cr_y) 
		w += 1
