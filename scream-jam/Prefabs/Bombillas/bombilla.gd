extends Node

var llamadaID: int = -1

enum BombillaState { ENCENDIDA, APAGADA, BIEN, MAL }
var _state: BombillaState = BombillaState.APAGADA

@onready var visual: Sprite2D = $Sprite2D

const BOMBILLA_APAGADA = preload("uid://b47ldqjmtbv0u")
const BOMBILLA_ENCENDIDA = preload("uid://bi8olk2ndemn5")
const BOMBILLA_BIEN = preload("uid://c8j1jeweyw0b7")
const BOMBILLA_MAL = preload("uid://b0n3cw0d32fxf")

# --- BASE ------------------------------------------------
func _ready() -> void:
	self.add_to_group("bombillas")
	reset()

var countdown: bool = false
var timeToStopMal: float = 2.0
var elapsedTime: float = 0.0
var _last_state: BombillaState = BombillaState.APAGADA

func _process(delta: float) -> void:
	if _state == BombillaState.MAL:
		if not countdown:
			return
		if elapsedTime >= timeToStopMal:
			setState(_last_state)
			elapsedTime = 0.0
			countdown = false
		else:
			elapsedTime += delta

# --- METODOS PUBLICOS ------------------------------------------------
func setState(state: BombillaState) -> void:
	# Guardar el estado anterior si vamos a entrar en MAL (o siempre si lo necesitas)
	if state == BombillaState.MAL:
		_last_state = _state   # guardamos el estado anterior antes de cambiar
		_state = state
		elapsedTime = 0.0
		countdown = true
	else:
		# Si salimos de MAL, asegurarnos de detener el countdown
		if _state == BombillaState.MAL:
			countdown = false
			elapsedTime = 0.0
		_state = state

	_setImage()

func reset() -> void:
	setState(BombillaState.APAGADA)
	llamadaID = -1

func check(correcta: bool) -> void:
	if correcta:
		setState(BombillaState.BIEN)
	else:
		setState(BombillaState.MAL)

func unPlug() -> void:
	if llamadaID != -1:
		setState(BombillaState.ENCENDIDA)
	else:
		setState(BombillaState.APAGADA)

func setLlamada(id: int) -> void:
	llamadaID = id
	setState(BombillaState.ENCENDIDA)

# --- METODOS PRIVADOS ------------------------------------------------
func _setImage() -> void:
	# SONIDO AQUI
	match _state:
		BombillaState.ENCENDIDA:
			visual.texture = BOMBILLA_ENCENDIDA
		BombillaState.APAGADA:
			visual.texture = BOMBILLA_APAGADA
		BombillaState.BIEN:
			visual.texture = BOMBILLA_BIEN
		BombillaState.MAL:
			visual.texture = BOMBILLA_MAL

func _PlayLlamada() -> void:
	# Si no hay llamada return
	if llamadaID == -1:
		return
	# SONIDO AQUI

# --- CONEXIONES ------------------------------------------------
func _on_button_pressed() -> void:
	# Queremos ejecutar solo si el estado NO es APAGADA y NO es BIEN:
	if _state != BombillaState.APAGADA and _state != BombillaState.BIEN:
		_PlayLlamada()

func _on_button_mouse_entered() -> void:
	self.scale = Vector2(1.05, 1.05) # feedback

func _on_button_mouse_exited() -> void:
	self.scale = Vector2(1, 1) # feedback
