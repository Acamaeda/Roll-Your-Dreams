extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.ui_rescale.connect(rescale)
	rescale()

func rescale():
	scale = UI.scale

func add_score_display(counter : ScoreCounter):
	var display : ScoreDisplay = load("res://Engine/UI/ScoreDisplay.tscn").instantiate()
	display.counter = counter
	get_node("Displays").add_child(display)
