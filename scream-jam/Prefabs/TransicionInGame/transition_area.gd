extends Node

@export var current_scene : Global.Scenes = Global.Scenes.NULL
@export var to_scene : Global.Scenes = Global.Scenes.NULL
@onready var flecha: Control = $Control

func _on_mouse_entered() -> void:
	flecha.scale = Vector2(1.2,1.2)

func _on_mouse_exited() -> void:
	flecha.scale = Vector2(1,1)

func _on_click() -> void:
	Global.current_scene = current_scene
	Global.to_scene = to_scene
	Global.totransition.emit()
