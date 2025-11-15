extends Node

@export var weight : int = 5
var _clavijas = []
const CLAVIJA = preload("uid://bgoopn5ii5cak")

func _ready() -> void:
	for i in  weight: #clavijas
		_clavijas.append(CLAVIJA.instantiate())
		self.add_child(_clavijas[i])
		
		_clavijas[i].position = Vector2(i * 100, 100) 
		_clavijas[i].reset()

func find_closest_enchufe(point: Vector2, max_distance: float = INF) -> Node2D:
	var ref_point: Vector2 = point
	var max_sq := max_distance * max_distance
	var best: Node = null
	var best_sq := INF
	
	# Recorre todos los nodos en el grupo "dropZone"
	for dz in get_tree().get_nodes_in_group("dropZone"):
		# Si el enchufe ya tiene clavija (propiedad _clavija) lo saltamos.
		# get(prop, default) devuelve default si la propiedad no existe.
		if dz.get("_clavija") != null:
			continue
		# Se utiliza el cuadrado porque es mas eficiente.
		# Distancia al cuadrado entre el punto de referencia y el enchufe.
		var d_sq : float = (dz.global_position - ref_point).length_squared()
		# Ignorar si esta fuera del maximo permitido.
		if max_distance != INF and d_sq > max_sq:
			continue
			
		# Mantener el mas cercano.
		if d_sq < best_sq:
			best_sq = d_sq
			best = dz
	
	return best
