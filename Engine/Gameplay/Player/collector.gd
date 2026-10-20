@tool

extends Area3D
var player_body:PhysicsBody3D
var nonrolling:Node3D
var sticked:Node3D
signal size_changed(size, rollup_size)
signal rolled_up(object)
var size: float = 1.0
var control: LevelControl

@export_enum("Absorb", "Sticky without collision") var mode = 0

@export var rollup_ratio = 2.15
@export var exponent = 3.0
@export var growth_mult = 1.0
var volume = 1.0 

var max_volume_taken = 0.8
var outer_volume = 0.0

var old_size: float = 0.0

func _ready() -> void:
	player_body = get_parent()
	sticked= player_body.get_node("Nonscaling/Sticked")
	control = get_tree().get_first_node_in_group("Level Control")
	if (!control):
		return
	
	size = control.level_scale * player_body.scale.x
	volume = pow(size, exponent)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (size != old_size):
		size_changed.emit(size, size / rollup_ratio)
		old_size = size
	
# Returns the size reserved for the outer volume so it can be attached to the sticked object	
func give_size_with_mults(amount, _extra_mult = 1.0):
	var mults = 1.0
	mults *= growth_mult * _extra_mult
	var new_volume = max(mults, 1.0) * max_volume_taken * pow(amount, exponent)
	outer_volume += new_volume
	amount *= pow(mults, 1/exponent)
	add_size(amount)
	return new_volume
	
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
	var reserved_volume = give_size_with_mults(rollup.size, rollup.growth_mult)
	rollup.rolled_up()
	absorb(other, reserved_volume)
	Utils.delete_node(other)

func absorb(other : Node3D, reserved_volume):
	var absorbed : Node3D
	match mode:
		0: 
			absorbed = load("res://Engine/Gameplay/Rollable/AbsorbedObject.tscn").instantiate()
			player_body.get_parent().add_child(absorbed)
		1: 
			absorbed = load("res://Engine/Gameplay/Rollable/StickedObject.tscn").instantiate()
			sticked.add_child(absorbed)
			absorbed.reserved_volume = reserved_volume
	absorbed.global_transform = other.global_transform
	absorbed.player = player_body
	absorbed.size = size
	var sound :AudioStreamPlayer = other.get_node_or_null("RollupSound")
	if (sound):
		sound.reparent(absorbed, true)
		sound.play.call_deferred()
	rolled_up.emit(other)
	var model = Node3D.new()
	absorbed.add_child(model)	
	rescue_meshes(other, model, true)
	
	other.global_position = Vector3(0, 0, 0)
	other.global_rotation = Vector3.ZERO
	other.global_transform.basis = other.global_transform.basis.orthonormalized()
	var model2 = Node3D.new()
	rescue_meshes(other, model2, false)
	control.get_node("Hud/Main/Rollup_Popup").update(other, model2)
	Utils.delete_node.call_deferred(other)

func rescue_meshes(other, absorbed, copy):
	for child in other.get_children():
		if (child is VisualInstance3D):
			if (copy):
				other.add_child(child.duplicate())
			child.reparent(absorbed, true)
		else:
			rescue_meshes(child, absorbed, copy)

func absorb_sticked_objects():
	outer_volume = 0.0
	for child in sticked.get_children():
		sticked.remove_child(child)
