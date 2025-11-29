extends Node

@onready var music_emitter: FmodEventEmitter2D = $music_2D
@onready var ambience_emitter: FmodEventEmitter2D = $ambience_2D

# --- MUSICA ----------------------------------------------------------------
## Reproduce musica.
func play_music(event_name: String):
	# Comprueba entrada vacía
	if not event_name or event_name.strip_edges() == "":
		push_error("AudioManager.play_sfx: event_path vacío. Callsite should provide valid event path.")
		return
	
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
	# Comprueba entrada vacía
	if not event_name or event_name.strip_edges() == "":
		push_error("AudioManager.play_sfx: event_path vacío. Callsite should provide valid event path.")
		return
	
	var emitter = FmodEventEmitter2D.new()
	emitter.auto_release = true
	emitter.preload_event = false
	self.add_child(emitter)
	emitter.event_name = event_name
	emitter.set_event_name (event_name)
	emitter.play()

## Reproduce un sfx con posicion.
func play_sfx_2d(event_name: String, pos: Vector2):
	# Comprueba entrada vacía
	if not event_name or event_name.strip_edges() == "":
		push_error("AudioManager.play_sfx: event_path vacío. Callsite should provide valid event path.")
		return
	
	# Creamos y colocamos el emitter
	var emitter := FmodEventEmitter2D.new()
	emitter.auto_release = true
	emitter.preload_event = true
	emitter.global_position = pos
	self.add_child(emitter)
	emitter.set_event_name (event_name)
	emitter.play()

# --- AMBIENCE ----------------------------------------------------------------

## Reproduce un sonido ambiente
func play_ambience(event_name: String):
	# Comprueba entrada vacía
	if not event_name or event_name.strip_edges() == "":
		push_error("AudioManager.play_sfx: event_path vacío. Callsite should provide valid event path.")
		return
	
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
