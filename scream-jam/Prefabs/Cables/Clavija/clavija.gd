extends Node2D
# Bombilla a la que va ligada la clavija
var bombilla: Node2D = null
# Enchufe al que tiene que ir la clavija
var objetivo: int
# Dragger de la clavija
@onready var Dragger: Node2D = $visual

func _ready() -> void:
	self.add_to_group("clavijas")
	reset()

func reset() -> void:
	#objetivo = -1
	Dragger.reset()
func check(correct):
	if bombilla!= null:
		bombilla.check(correct)
