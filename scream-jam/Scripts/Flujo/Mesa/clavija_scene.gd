extends Node2D

#fin de juego
var noMasLlamadas: bool = false
# Numero de llamadas completadas este nivel
var completedCalls: int = 0

# tiempo de espera para tener un nuevo nivel
var maxTime:float = 1
var elapsedTime: float = 0
var newlevel: bool = false

# Managers
@onready var clavijas_manager: Node2D = $ClavijasManager
@onready var enchufes_manager: Node2D = $EnchufesManager
@onready var bombillas_manager: Node2D = $BombillasManager
@onready var dialogue_box: Control = $Fondo/DialogueBox


var rng = RandomNumberGenerator.new()


# --- BASE --------------------------------------------------------

func _ready() -> void:
	Global.connect("endedCall",_endedCall)
	
	# Genera las estructuras de datos de las narrativas.
	enchufes_manager.start()
	# Inicializacion de las cosas
	clavijas_manager.start()
	bombillas_manager.start()
	
	clavijas_manager.setBombillas(bombillas_manager._bombillas)
	Global.startGame.connect(_startGame)

func _startGame() ->void:
	Global.generate_narrative()
	_new_level()

# --- METODOS PUBLICOS --------------------------------------------------------
func check():
	enchufes_manager.check()
	pass

func play_call(id:int):
	dialogue_box.visible = true
	dialogue_box.start_narrative_ID(id)
	pass
	
# --- METODOS PRIVADOS --------------------------------------------------------
# Contador de llamadas atendidas
func _endedCall(id: int) ->void:
	completedCalls += 1
	if completedCalls >= Global.niveles[Global.nivel]:
		_new_level()
		completedCalls = 0
# Empieza el siguiente nivel
func _new_level():
	Global.nivel += 1
	# Se han completado todos los niveles.
	if Global.nivel >= len(Global.niveles):
		noMasLlamadas = true
		# TRANSICION A LA ESCENA FINAL.
		Global.current_scene = Global.Scenes.CLAVIJAS
		Global.to_scene = Global.Scenes.CREDITS
		Global.totransition.emit()
		return
	# Empieza nivel nuevo
	await get_tree().create_timer(2.0).timeout  # Espera 1 segundo
	clavijas_manager.setCallID()

# --- CONEXIONES --------------------------------------------------------
func _on_check_clavijas_button_down() -> void:
	check()
