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


func _ready() -> void:
	#Global.nextLevel.connect(_onCheck)
	# Inicializacion de las cosas
	clavijas_manager.start()
	enchufes_manager.start()
	bombillas_manager.start()
	
	clavijas_manager.setBombillas(bombillas_manager._bombillas)

func _new_level():
	pass
	#asigna los numeros 0 a los clavijeros
	
	var usedPos = []
	
	#establece las llamadas y sus clavijeros
	for i in Global.niveles[Global.nivel]:
		if Global.llamadaActual >= JsonData.json_data.Dialoges.size()-1:
			noMasLlamadas= true
			print("Se acabo el juego")
		
		# setea el numero en el clavijero
		#gridClavijeros[JsonData.json_data.Dialoges[Global.llamadaActual].Clavijero].DropZone = Global.llamadaActual
		
		# creamos un numero aleatorio no usado
		var my_random_number = rng.randi_range(0, 4)
		while not my_random_number in usedPos:
			usedPos.append(my_random_number)
			my_random_number = rng.randi_range(0, 4)
		# numero del cable a reproducir primero
		Global.primerCable = my_random_number
		
		# si no esta el numero en el array asigna sus cosas a la clavija
		$CheckClavijas.grid[my_random_number].clavijaState = Global.ClavijasState.REGU
		Global.SceneManager.sfx_2.stream = load("res://Sounds/clavijas/encendido_bombilla.wav")
		Global.SceneManager.sfx_2.play()
		$CheckClavijas.grid[my_random_number].Clavija = Global.llamadaActual
		$CheckClavijas.grid[my_random_number].refBombilla.get_parent().llamadaID = Global.llamadaActual
		Global.llamadaActual += 1
	
	Global.nivel += 1
func _process(delta: float) -> void:
	pass

func check():
	enchufes_manager.check()
	pass
