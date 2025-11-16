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


var rng = RandomNumberGenerator.new()


# --- BASE --------------------------------------------------------

func _ready() -> void:
	# Inicializacion de las cosas
	clavijas_manager.start()
	enchufes_manager.start()
	bombillas_manager.start()
	
	clavijas_manager.setBombillas(bombillas_manager._bombillas)

func _process(delta: float) -> void:
	pass

# --- METODOS PUBLICOS --------------------------------------------------------
func check():
	enchufes_manager.check()
	pass

# --- METODOS PRIVADOS --------------------------------------------------------
func _new_level():
	pass

# --- CONEXIONES --------------------------------------------------------
func _on_check_clavijas_button_down() -> void:
	check()
