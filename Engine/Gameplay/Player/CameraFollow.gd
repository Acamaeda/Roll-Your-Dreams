extends Camera3D

var target
var speed = 4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent().get_node("SpringArm3D/Focus")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = lerp(position, target.position, delta*speed)
