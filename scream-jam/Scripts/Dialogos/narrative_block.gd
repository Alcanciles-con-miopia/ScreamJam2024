extends RefCounted
class_name NarrativeBLock

var callbacks : Array[Callable]
var condition_continue: Callable = Callable()
var text := ""
var soundChannel := -1
var character : NarrativeCharacter
var emotion : NarrativeCharacter.Emotion
var continue_ := true

## Constructora
## [code]txt[code] (String) texto a mostrar
## [code]snd[code] (String) ruta al sonido
func _init(chr : NarrativeCharacter = null, emt := NarrativeCharacter.Emotion.NEUTRAL, txt := "") -> void:
	emotion = emt
	character = chr
	text = txt

## Crea un bloque “vacio” sin texto ni sonido
static func empty_block() -> NarrativeBLock:
	var block = NarrativeBLock.new()
	# No ponemos character, no ponemos texto → queda “vacío”
	block.character = null
	block.emotion = NarrativeCharacter.Emotion.NULL
	block.text = ""
	return block

## Cambia el texto a mostrar
## [code]txt[code] (String) texto a mostrar
func set_text(txt:= "") -> void:
	text = txt

## Cambia el canal de reproduccion del sonido
## [code]channel[code] (int) canal por el que quieres que salga, se asigna automaticamente
func set_sound_channel(channel:= -1) -> void:
	soundChannel = channel

## Aniade un callback que se ejecutara al reproducir
## [code]call[code] (Callable) metodo
func add_callable(call:Callable) -> void:
	if call:
		callbacks.append(call)

## Aniade un callback condicion para continuar al siguiente dialogo
## [code]call[code] (Callable) metodo
func add_condition(call:Callable) -> void:
	if call.is_valid():
		condition_continue = call

## Configura la label segun el hablante
func configure_label(label: Label) ->void:
	if character == null: return
	if character.font != null: label.add_theme_font_override("font", character.font)
	if character.color != null: label.add_theme_color_override("font_color", character.color)

## Coprueba si puede pasar al siguiente dialogo
## [code]return[code] (bool)
func can_continue() -> bool:
	if condition_continue.is_null(): return true
	return condition_continue.call()

## Devuelve el texto y ejecuta los callbacks y el sonido del dialogo
func reproduce() -> String:
	for c in callbacks:
		c.call()
	# SONIDO AQUI
	#SoundSystem.play_sfx(character.get_sound(emotion), soundChannel)
	return text
