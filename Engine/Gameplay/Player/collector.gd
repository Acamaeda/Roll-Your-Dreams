@tool

extends Node3D
@export var player_body:PhysicsBody3D
var nonrolling:Node3D
signal size_changed(size, rollup_size)

var size: float = 1.0

@export var rollup_ratio = 2.15
@export var exponent = 3.0
var volume = 1.0

var old_size: float = 0.0

func _ready() -> void:
	player_body = get_parent()
	size = player_body.scale.x
	volume = pow(size, exponent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (size != old_size):
		size_changed.emit(size, size / rollup_ratio)
		old_size = size
		


func add_size(amount): 
	volume += pow(amount, exponent)
	size = pow(volume, 1/exponent)
	
func _on_body_entered(other):
	var rollup = other.get_node("Rollup")
	if (!rollup):
		return
	add_size(rollup.size)
	other.queue_free()
