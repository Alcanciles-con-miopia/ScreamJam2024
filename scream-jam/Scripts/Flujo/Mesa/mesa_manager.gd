extends Scene

var postitsTraducidos: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if JsonParser.json_data != null and not postitsTraducidos:
		postitsTraducidos = true
		$PostitiTutoPapel/Label.text = JsonParser.json_data.UI.Papers
		$PostitiTutoBasura/Label.text = JsonParser.json_data.UI.Discarts
		$PostitiTutoCalle/Label.text = JsonParser.json_data.UI.Clue
