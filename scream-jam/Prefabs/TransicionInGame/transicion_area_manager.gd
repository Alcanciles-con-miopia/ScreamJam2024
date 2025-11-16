extends Control
# Escena actual
@export var current_scene : Global.Scenes = Global.Scenes.NULL
# Izquierda
@export var to_scene_left : Global.Scenes = Global.Scenes.NULL
# Abajo
@export var to_scene_right : Global.Scenes = Global.Scenes.NULL
# Derecha
@export var to_scene_down : Global.Scenes = Global.Scenes.NULL
# Arriba
@export var to_scene_top : Global.Scenes = Global.Scenes.NULL

const TRANSITION_AREA = preload("uid://dwjm2d85wwbrd")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Izquierda
	if to_scene_left != Global.Scenes.NULL:
		_create_transition_area(to_scene_left)
	# Derecha
	if to_scene_left != Global.Scenes.NULL:
		_create_transition_area(to_scene_right)
	# Abajo
	if to_scene_left != Global.Scenes.NULL:
		_create_transition_area(to_scene_down)
	# Arriba
	if to_scene_left != Global.Scenes.NULL:
		_create_transition_area(to_scene_top)

# Crea un boton
func _create_transition_area(to_scene) -> void:
	var TA = TRANSITION_AREA.instantiate()
	TA.reparent(self)
	TA.current_scene = current_scene
	TA.to_scene = to_scene

# ajusta el tamanyo
func _configure_button() -> void:
	pass
