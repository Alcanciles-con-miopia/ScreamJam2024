extends Node2D

var isDraggable = true
var clicked = false 			# Para saber si esta arrastrandose.
var overlapping_dropzones := []	# Dropzones overlapeadas.

@onready var cable: Line2D = $"../Line2D"
@onready var origin: Node2D = $"../Origin"
@onready var clavijaVis: Node2D = $ButtonContainer
@onready var button: Button = $ButtonContainer/Button
@onready var cable_point: Node2D = $CablePoint

const CLAVIJA_INSER = preload("uid://6saxmlaafvtu")
const CLAVIJA_SUELTA = preload("uid://djiuuiilhi5j6")

# --- BASE ------------------------------------------------
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if isDraggable and clicked and event is InputEventMouseMotion:
				position = event.position

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	if clicked:
		# posicion y rotacion de la clavija
		global_position = get_global_mouse_position()
		self.look_at(origin.position)
		self.rotation_degrees -= 90
	# Linea de cable
	# obtener posición global del cable_point y convertirla al espacio local de 'cable'
		var gp := cable_point.global_position
		cable.points[0] = cable.to_local(gp)
	else:
		# si no está clickeado, usar la posición actual del nodo (global -> local de 'cable')
		cable.points[0] = cable.to_local(global_position)

	# el extremo del cable apuntando al origin (también convertido al espacio local de 'cable')
	cable.points[1] = cable.to_local(origin.global_position)

func _ready() -> void:
	origin.global_position = global_position

# --- METODOS PUBLICOS ------------------------------------------------

## Resetea posicion y enchufe objetivo
func reset():
	_resetPos()

# --- METODOS PRIVADOS ------------------------------------------------

## PRIVATE
## Comprueba que hacer con el dropzone cuando sueltas una clavija.
func _checkDropZone() -> void:
	# Busca una dropzone valida en la lista (la primera libre)
	var dz = _findObjetiveEnchufe()
	if dz == null:
		# si ninguna valida -> reset
		_resetPos()
		return
	# Insertamos la clavija en el enchufe.
	dz.insertar(get_parent())
	global_position = dz.global_position
	button.icon = CLAVIJA_INSER
	clavijaVis.position = Vector2(0,0)
	# Sonido
	#Global.SceneManager.sfx.stream = load("res://Sounds/clavijas/210313__soundscape_leuphana__20131209_plug-out_olympusls10_xy.wav")
	#Global.SceneManager.sfx.play()

## Distancia maxima a considerar un enchufe para attachar
const MAX_ATTACH_DISTANCE := 60
const MAX_ATTACH_DISTANCE_SQ := MAX_ATTACH_DISTANCE * MAX_ATTACH_DISTANCE

## PRIVATE
## Selecciona el enchufe mas cercano de los que hay en el rango si hay.
func _findObjetiveEnchufe() -> Node2D:
	var objetiveEnchufe: Node2D = null
	if overlapping_dropzones.is_empty():
		return null
	var min_distance_sq := INF
	for dz in overlapping_dropzones:
		if dz._clavija != null:
			continue
		# length_squared se usa el cuadrado porque es mas eficiente
		var distance_sq = (global_position - dz.global_position).length_squared()
		# ignorar si demasiado lejos
		if distance_sq > MAX_ATTACH_DISTANCE_SQ:
			continue
		if distance_sq < min_distance_sq:
			min_distance_sq = distance_sq
			objetiveEnchufe = dz
	return objetiveEnchufe

## Desfase visual para cuadrar clavija con en movimiento
var MOVEMENT_CLAVIJA_OFFSET := Vector2(0, 55)

## PRIVATE
## Resetea la posicion al origen.
func _resetPos():
	# ---- tween
	var tweenPos = get_tree().create_tween() # crea tween en la jerarquia
	tweenPos.tween_property(self, "global_position", origin.global_position, 0.2).set_ease(Tween.EASE_OUT)
	var tweenRot = get_tree().create_tween() # crea tween en la jerarquia
	tweenRot.tween_property(self, "rotation_degrees", 90, 0.2).set_ease(Tween.EASE_OUT)
	button.icon = CLAVIJA_SUELTA



# --- Conexiones ------------------------------------------------
## PRIVATE
func _on_area_2d_mouse_entered():
	if not Global.isDragging: # si no se esta draggeando nada
		isDraggable = true 		# se puede draggear
		scale = Vector2(1.05, 1.05) # feedback
		
## PRIVATE
func _on_area_2d_mouse_exited():
	if not Global.isDragging: # si no se esta draggeando nada
		isDraggable = false 	# resetea isDraggable
		scale = Vector2(1, 1) # feedback
## PRIVATE
func _on_area_2d_body_entered(body: Node2D) -> void:
	# si entra en una dropzone
	if body.is_in_group('dropZone') and body not in overlapping_dropzones:
		overlapping_dropzones.append(body)
## PRIVATE
func _on_area_2d_body_exited(body: Node2D) -> void:
	# Comprobar si sale de un dropzone
	if body.is_in_group('dropZone') and body in overlapping_dropzones:
		overlapping_dropzones.erase(body)
## PRIVATE
func _on_button_button_down() -> void:
	button.icon = CLAVIJA_SUELTA
	clicked = true
	clavijaVis.position = MOVEMENT_CLAVIJA_OFFSET
	
	# Si ya estabas en una dropzone, limpiar:
	for dz in overlapping_dropzones:
		if dz._clavija == get_parent():
			dz._clavija = null
## PRIVATE
func _on_button_button_up() -> void:
	clicked = false
	_checkDropZone()
