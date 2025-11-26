extends Node

@onready var music_emitter: FmodEventEmitter2D = $music_2D
@onready var ambience_emitter: FmodEventEmitter2D = $ambience_2D

# --- MUSICA ----------------------------------------------------------------
## Reproduce musica.
func play_music(event_name: String):
	# Paramos
	music_emitter.stop()
	# Setteamos
	music_emitter.set_event_name(event_name)
	# Reproducimos
	music_emitter.play()

## Para la musica.
func stop_music():
	music_emitter.stop()
	
## Settea un parametro del evento musica actual
func set_music_param(param: String, value: float):
	music_emitter.set_parameter(param, value)


# --- SFX ----------------------------------------------------------------
## Reproduce un SFX sin posicion.
func play_sfx(event_name: String):
	var emitter = FmodEventEmitter2D.new()
	add_child(emitter)
	emitter.set_event_name(event_name)
	emitter.play()
	emitter.auto_release = true

## Reproduce un sfx con posicion.
func play_sfx_2d(event_name: String, pos: Vector2):
	# Creamos y colocamos el emitter
	var emitter := FmodEventEmitter2D.new()
	add_child(emitter)
	emitter.global_position = pos
	emitter.set_event_name (event_name)
	emitter.play()
	emitter.auto_release = true

# --- AMBIENCE ----------------------------------------------------------------

## Reproduce un sonido ambiente
func play_ambience(event_name: String):
	# Paramos
	ambience_emitter.stop()
	# Setteamos
	ambience_emitter.set_event_name(event_name)
	# Reproducimos
	ambience_emitter.play()


func stop_ambience():
	ambience_emitter.stop()

func set_ambience_param(param: String, value: float):
	ambience_emitter.set_parameter(param, value)
