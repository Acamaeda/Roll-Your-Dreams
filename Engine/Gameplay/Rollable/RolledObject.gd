extends Node3D
var player : Node
var speed = 3.0
var size = 1.0;
var shrink_factor = 0.3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position+= player.linear_velocity * delta
	var distance = player.position - position
	var step_size = speed * delta *player.scale.x
	if (step_size > distance.length()):
		queue_free()
		return
	var direction = (distance).normalized() 
	position += direction * step_size
	
	var new_size = scale.x * pow(shrink_factor, delta)
	scale = Vector3(new_size, new_size, new_size)
