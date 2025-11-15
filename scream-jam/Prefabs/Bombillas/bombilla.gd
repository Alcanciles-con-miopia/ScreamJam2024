extends Node

var llamadaID: int = -1

enum BombillaState{ENCENDIDA, APAGADA, BIEN, MAL}
var _state:BombillaState = BombillaState.APAGADA

@onready var visual: Sprite2D = $Sprite2D

const BOMBILLA_APAGADA = preload("uid://b47ldqjmtbv0u")
const BOMBILLA_ENCENDIDA = preload("uid://bi8olk2ndemn5")
const BOMBILLA_BIEN = preload("uid://c8j1jeweyw0b7")
const BOMBILLA_MAL = preload("uid://b0n3cw0d32fxf")

# --- BASE ------------------------------------------------
func _ready() -> void:
	self.add_to_group("bombillas")
	reset()

var countdown:bool = false
var timeToStopMal:float = 2
var elapsedTime:float = 0
func _process(delta: float) -> void:
	if _state == BombillaState.MAL:
		if !countdown: return
		if elapsedTime >= timeToStopMal:
			setState(BombillaState.ENCENDIDA)
			elapsedTime = 0
			countdown = false
		else: 
			elapsedTime += delta

# --- METODOS PUBLICOS ------------------------------------------------
func setState(state:BombillaState):
	_state = state
	_setImage()

func reset():
	setState(BombillaState.APAGADA)
	llamadaID = -1

func check(correcta):
	if correcta:
		setState(BombillaState.BIEN)
	else:
		setState(BombillaState.MAL)

func setLlamada(id: int):
	llamadaID = id
	setState(BombillaState.ENCENDIDA)

# --- METODOS PRIVADOS ------------------------------------------------
func _setImage():
	match _state:
		BombillaState.ENCENDIDA:
			visual.texture = BOMBILLA_ENCENDIDA
		BombillaState.APAGADA:
			visual.texture = BOMBILLA_APAGADA
		BombillaState.BIEN:
			visual.texture = BOMBILLA_BIEN
		BombillaState.MAL:
			visual.texture = BOMBILLA_MAL
			countdown = true

func _PlayLlamada():
	pass

# --- CONEXIONES ------------------------------------------------
func _on_button_pressed() -> void:
	if _state != BombillaState.APAGADA or _state != BombillaState.BIEN:
		_PlayLlamada()


func _on_button_mouse_entered() -> void:
	self.scale = Vector2(1.05, 1.05) # feedback


func _on_button_mouse_exited() -> void:
	self.scale = Vector2(1, 1) # feedback
