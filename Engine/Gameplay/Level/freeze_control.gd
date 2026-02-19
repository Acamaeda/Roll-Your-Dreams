extends Node
var paused = false
var frozen = false

var pause_menu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pause_menu = UI.get_node("PauseMenu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Pause")):
		paused = !paused
		UI.TogglePauseGame.emit(paused)
		pause_menu._toggle_control(pause_menu.id, paused, pause_menu.id)
		if paused:
			get_tree().paused = true
		if !paused && !frozen:
			get_tree().paused = false
