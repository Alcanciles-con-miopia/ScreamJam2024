extends Node2D

#fin de juego
var noMasLlamadas: bool = false

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
	# Genera las estructuras de datos de las narrativas.
	enchufes_manager.start()
	Global.generate_narrative()
	# Inicializacion de las cosas
	clavijas_manager.start()
	bombillas_manager.start()
	
	clavijas_manager.setBombillas(bombillas_manager._bombillas)
	

func _process(delta: float) -> void:
	pass

# --- METODOS PUBLICOS --------------------------------------------------------
func check():
	enchufes_manager.check()
	pass

func validate_dialogue(narrativeBloc:NarrativeBLock, clavijero_actual:int):
	if narrativeBloc.get_condition().call(clavijero_actual):
		
		# Cargar esta narrativa
		pass
	pass

func play_call(id:int):
	dialogue_box.visible = true
	dialogue_box.start_narrative_ID(id)
	pass
	
# --- METODOS PRIVADOS --------------------------------------------------------
func _new_level():
	pass

# --- CONEXIONES --------------------------------------------------------
func _on_check_clavijas_button_down() -> void:
	check()
