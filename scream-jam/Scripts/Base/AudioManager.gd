extends Node

# Evento donde se reproduce el ambiente
var ambience
# Evento donde se reproducen las voces
var voice

# --- MUSICA (No funciona esta forma de hacerlo si queremos cambiar parametros en runtime) ----------------------------------------------------------------
### Reproduce musica.
#func play_music(event_name: String):
	## Comprueba entrada vacía
	#if not event_name or event_name.strip_edges() == "":
		#push_error("AudioManager.play_sfx: event_path vacio.")
		#return
	#
	## Paramos
	#music_emitter.stop()
	## Setteamos
	#music_emitter.set_event_name(event_name)
	## Reproducimos
	#music_emitter.play()
#
### Para la musica.
#func stop_music():
	#music_emitter.stop()
	#
### Settea un parametro del evento musica actual
#func set_music_param(param: String, value: float):
	#music_emitter.set_parameter(param, value)


# --- SFX ----------------------------------------------------------------
## Reproduce un SFX sin posicion.
func play_sfx(event_name: String):
	# Comprueba entrada vacía
	if not event_name or event_name.strip_edges() == "":
		push_error("AudioManager.play_sfx: event_path vacio.")
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
		push_error("AudioManager.play_sfx: event_path vacio.")
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
		push_error("AudioManager.play_sfx: event_path vacio.")
		return
		
	# Instancia del evento.
	ambience = FmodServer.create_event_instance(event_name)
	# Reproduce
	ambience.start()

func stop_ambience():
	if ambience == null:
		return
	
	# Libera la instancia
	ambience.release()
	ambience = null

func set_ambience_param(param: String, value: float):
	if ambience == null: return
	ambience.set_parameter_by_name(param, value)


# --- VOCES ----------------------------------------------------------------
func play_voice(character_id: int, emotion_value: float) -> void:
	# Instancia del evento.
	voice = FmodServer.create_event_instance("event:/Emocion")
	# Parametros.
	voice.set_parameter_by_name("Personajes", float(character_id))
	voice.set_parameter_by_name("Emociones", emotion_value)
	# Reproduce
	voice.start()
	# Libera la instancia
	voice.release()
