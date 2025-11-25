extends Node

@onready var sfx_emitter: FmodEventEmitter2D = $sfx_2D
@onready var music_emitter: FmodEventEmitter2D = $music_2D
@onready var ambience_emitter: FmodEventEmitter2D = $ambience_2D

var banks:= Array()

func _ready():
	# Cargar bancos FMOD
	banks.append(FmodServer.load_bank("res://FMOD/banks/Master.strings.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL))
	banks.append(FmodServer.load_bank("res://FMOD/banks/Master.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL))
	banks.append(FmodServer.load_bank("res://FMOD/banks/Tormenta.bank", FmodServer.FMOD_STUDIO_LOAD_BANK_NORMAL))
	print("FMOD: Bancos cargados correctamente " + str(FmodServer.get_all_banks().size()))

# --- MUSICA ----------------------------------------------------------------
## Reproduce musica en bucle.
func play_music(event_path: String):
	music_emitter.set_event(event_path)
	music_emitter.play()
	
## Para la musica.
func stop_music():
	music_emitter.stop()
	
## Settea un parametro del evento musica actual
func set_music_param(param: String, value: float):
	music_emitter.set_parameter(param, value)


# --- SFX ----------------------------------------------------------------
## Reproduce un SFX sin posicion.
func play_sfx(event_path: String):
	sfx_emitter.set_event_name (event_path)
	sfx_emitter.play()

## Reproduce un sfx con posicion.
func play_sfx_2d(event_path: String, pos: Vector2):
	# Creamos y colocamos el emitter
	var emitter := FmodEventEmitter2D.new()
	add_child(emitter)
	emitter.global_position = pos
	emitter.set_event_name (event_path)
	emitter.play()
	
	# borramos automaticamente cuando termina.
	emitter.finished.connect(emitter.queue_free)

# --- AMBIENCE ----------------------------------------------------------------

func play_ambience(event_path: String):
	print(event_path + "  |  "+ FmodServer.get_event_guid(event_path))
	ambience_emitter.event_guid = FmodServer.get_event_guid(event_path)
	ambience_emitter.play()

func stop_ambience():
	ambience_emitter.stop()

func set_ambience_param(param: String, value: float):
	ambience_emitter.set_parameter(param, value)
