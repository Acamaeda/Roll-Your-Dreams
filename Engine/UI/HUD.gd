extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UI.ui_rescale.connect(rescale)
	rescale()

func rescale():
	scale = UI.scale
