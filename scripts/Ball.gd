extends RigidBody2D

signal out_of_bounds

var default_v_multiplier: float = 200.0

export(float) var velocity_multiplier = default_v_multiplier
export(float) var acceleration = 3.0

var x: float = 0
var y: float = 0
var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect signals
	var e := connect("body_entered", self, "_on_body_entered")
	if e != 0:
		print(e)
	
	# determine starting direction
	randomize_dir()
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	linear_velocity.x = velocity_multiplier*x
	linear_velocity.y = velocity_multiplier*y
	rotation_degrees = 0
	
	# acceleration
	velocity_multiplier += acceleration*delta
	
	pass

func _on_body_entered(body: Node) -> void:
	var groups: Array = body.get_groups()
	match groups[0]:
		"wall_top", "wall_bottom":
			y = -y
			pass
		"wall_right":
			emit_signal("out_of_bounds", 2)
#			x = -x
			pass
		"wall_left":
			emit_signal("out_of_bounds", 1)
			pass
		_:
			if body.is_in_group("player"):
				x = -x
			pass

func randomize_dir() -> void:
	rng.randomize()
	match rng.randi_range(1, 2):
		1:
			rng.randomize()
			x = rng.randf_range(.5, 1.0)
		2:
			rng.randomize()
			x = rng.randf_range(-.5, -1.0)
	rng.randomize()
	match rng.randi_range(1, 2):
		1:
			y = sqrt(1-pow(x,2))
		2:
			y = -sqrt(1-pow(x,2))			
	pass
