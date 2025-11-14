extends Node2D
# Bombilla a la que va ligada la clavija
var bombilla: Node2D
# Enchufe al que tiene que ir la clavija
var objetivo: int

func _ready() -> void:
	reset()

func reset() -> void:
	objetivo = 1
