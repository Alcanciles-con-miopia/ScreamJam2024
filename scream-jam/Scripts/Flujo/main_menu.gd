extends Scene
class_name MainMenu

@onready var start_button: Button = $Start as Button
@onready var exit_button: Button = $VBoxContainer/Exit as Button
@onready var v_box_container: VBoxContainer = $VBoxContainer/VBoxContainer
@onready var exit: TextureButton = $VBoxContainer/Exit
@onready var labelLenguajes: Label = $VBoxContainer/Lenguages/Label
@onready var labelExit: Label = $VBoxContainer/Exit/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	JsonParser._load_lenguage("res://Jsons/englis.json")
	#start_button.button_down.connect(_on_start_down)
	#exit_button.button_down.connect(_on_exit_down)

func _on_start_down() -> void:
	Global.current_scene = Global.Scenes.MAIN_MENU
	Global.to_scene = Global.Scenes.CONTEXT
	Global.totransition.emit()
	# SONIDO AQUI
	#Global.SceneManager.sfx.stream = load("res://Sounds/cascos/422651__trullilulli__sfx-player-action-phone-pick-up.wav")
	#Global.SceneManager.sfx.play()


func _on_exit_down() -> void:
	# SONIDO AQUI
	#Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	#Global.SceneManager.sfx.play()
	get_tree().quit()
	pass

func _show_lenguages()-> void:
	# SONIDO AQUI
	#Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	#Global.SceneManager.sfx.play()
	v_box_container.visible = not v_box_container.visible 
	labelLenguajes.text = JsonParser.json_data.UI.Lenguage
	labelExit.text = JsonParser.json_data.UI.Exit
	exit.visible = not exit.visible

func _set_ingles()->void:
	# SONIDO AQUI
	#Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	#Global.SceneManager.sfx.play()
	JsonParser._load_lenguage("res://Jsons/englis.json")
	_show_lenguages()

func _set_espaniol()->void:
	#Global.SceneManager.sfx.stream = load("res://Sounds/papel/428652__jomse__postit1.wav")
	#Global.SceneManager.sfx.play()
	JsonParser._load_lenguage("res://Jsons/spanish.json")
	_show_lenguages()

func _on_start_button_down() -> void:
	Global.current_scene = Global.Scenes.MAIN_MENU
	Global.to_scene = Global.Scenes.CLAVIJAS
	Global.totransition.emit()

func _on_exit_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.

func on_enable() -> void:
	pass
