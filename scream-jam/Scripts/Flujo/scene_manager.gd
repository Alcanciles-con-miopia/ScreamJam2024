extends Node
@onready var ambient_sound: AudioStreamPlayer2D = $AmbientSound
@onready var ambient_sound_2: AudioStreamPlayer2D = $AmbientSound2
@onready var sfx: AudioStreamPlayer2D = $SFX
@onready var sfx_2: AudioStreamPlayer2D = $SFX2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.SceneManager = self
	Global.totransition.connect(_on_totransition)
	Global.transitioned.connect(_on_fade_scene_transitioned)

func _on_totransition() -> void: #fade in
	$FadeScene.transition()

func _on_fade_scene_transitioned() -> void: #justo antes del fadeout, la idea es que esto sea un switch
	#if Global.current_scene == Global.to_scene:
		 #pass
	match Global.current_scene:
		Global.Scenes.MAIN_MENU:
			$MainMenu.visible = false
			$MainMenu.on_disable()
			$MainMenu.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.CLAVIJAS:
			$ClavijasScene.visible = false
			$ClavijasScene.on_disable()
			$ClavijasScene.process_mode = Node.PROCESS_MODE_INHERIT
		Global.Scenes.MESA:
			$MesaScene.visible = false
			$MesaScene.on_disable()
			$MesaScene.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.PUERTA:
			$PuertaScene.visible = false
			$PuertaScene.on_disable()
			$PuertaScene.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.CREDITS:
			$Credits.visible = false
			$Credits.on_disable()
			$Credits.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.INTRO:
			$Intro.visible = false
			$Intro.on_disable()
			$Intro.process_mode = Node.PROCESS_MODE_DISABLED
		Global.Scenes.CONTEXT:
			$ContextoScene.visible = false
			$ContextoScene.on_disable()
			$ContextoScene.process_mode = Node.PROCESS_MODE_DISABLED
		_:
			print("hola")
	match Global.to_scene:
		Global.Scenes.MAIN_MENU:
			$MainMenu.visible = true
			$MainMenu.process_mode = Node.PROCESS_MODE_INHERIT
			$MainMenu.on_enable()
			ambient_sound.play()
			ambient_sound_2.play()
		Global.Scenes.CLAVIJAS:
			$ClavijasScene.visible = true
			$ClavijasScene.process_mode = Node.PROCESS_MODE_INHERIT
			$ClavijasScene.on_enable()
		Global.Scenes.MESA:
			$MesaScene.visible = true
			$MesaScene.process_mode = Node.PROCESS_MODE_INHERIT
			$MesaScene.on_enable()
		Global.Scenes.PUERTA:
			$PuertaScene.visible = true
			$PuertaScene.process_mode = Node.PROCESS_MODE_INHERIT
			$PuertaScene.on_enable()
		Global.Scenes.CREDITS:
			$Credits.visible = true
			$Credits.process_mode = Node.PROCESS_MODE_INHERIT
			$Credits.on_enable()
		Global.Scenes.INTRO:
			$Intro.visible = true
			$Intro.process_mode = Node.PROCESS_MODE_INHERIT
			$Intro.on_enable()
		Global.Scenes.CONTEXT:
			$ContextoScene.visible = true
			$ContextoScene.process_mode = Node.PROCESS_MODE_INHERIT
			$ContextoScene.on_enable()
		_:
			print("hola")
	Global.current_scene = Global.to_scene
