extends Control
class_name NarrativeBox

@onready var label: Label = $Button/Label

var actualNarrative := -1

var textDisplayed: float = 0 # contador para que se escriba letra a letra

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if textDisplayed < 1:
		textDisplayed += delta 
		label.visible_ratio = textDisplayed
	elif self.visible:
		if Global.narrativas[actualNarrative].is_end():
			await get_tree().create_timer(2.0).timeout  # Espera 1 segundo
			self.visible = false
			return

### METODOS BOTONES

func next_dialogue() -> void:
	Global.narrativas[actualNarrative].advance_block(label)
	textDisplayed = 0

func _on_button_mouse_entered():
	var tween = create_tween()
	tween.tween_property(self, "rotation_degrees", -0.5, 0.1)
	tween.tween_property(self, "rotation_degrees", 0, 0.1)

### METODOS CALLBACKS
func stop_input():
	Global.startTalking.emit()
	print("STOP INPUT")

func start_input():
	Global.stopTalking.emit()
	print("START INPUT")

func start_narrative_ID(id: int) ->void:
	actualNarrative = id
	label.text = ""
	next_dialogue()
	self.visible = true

func next_narrative() -> void:
	start_narrative_ID(actualNarrative + 1)
