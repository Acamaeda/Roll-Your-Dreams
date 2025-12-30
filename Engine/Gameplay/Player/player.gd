extends Node3D
@export var player_body:PhysicsBody3D
var nonrolling:Node3D

@export var size: float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nonrolling = get_node("Nonrolling")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#player_body.scale = Vector3.ONE * size;
	nonrolling.scale = Vector3.ONE * size;

	pass
	
