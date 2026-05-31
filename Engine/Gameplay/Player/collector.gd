@tool

extends Node3D
@export var player_body:PhysicsBody3D
var nonrolling:Node3D
signal size_changed(size, rollup_size)

var size: float = 1.0

@export var rollup_ratio = 2.15
@export var exponent = 3.0
@export var growth_mult = 1.0
var volume = 1.0

var old_size: float = 0.0

func _ready() -> void:
	player_body = get_parent()
	size = player_body.scale.x
	volume = pow(size, exponent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (size != old_size):
		size_changed.emit(size, size / rollup_ratio)
		old_size = size
		
func give_size_with_mults(amount):
	var mults = 1
	mults *= growth_mult
	amount *= pow(mults, 1/exponent)
	add_size(amount)
	
func add_size(amount): 
	volume += pow(amount, exponent)
	size = pow(volume, 1/exponent)

func set_size(amount):
	volume = pow(amount, exponent)
	size = amount


func _on_body_entered(other):
	var rollup = other.get_node("Rollable")
	if (!rollup):
		return
	give_size_with_mults(rollup.size)
	rollup.rolled_up()
	absorb(other)	
	Utils.delete_node(other)

func absorb(other):
	var absorbed = load("res://Engine/Gameplay/Rollable/RolledObject.tscn").instantiate()
	absorbed.transform = other.transform
	absorbed.player = player_body
	absorbed.size = size
	
	player_body.get_parent().add_child(absorbed)
	for child in other.get_children():
		if (child is VisualInstance3D):
			child.reparent(absorbed, true)
		else:
			for grandchild in child.get_children():
				if (grandchild is VisualInstance3D):
					grandchild.reparent(absorbed, true)
