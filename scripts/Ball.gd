extends RigidBody2D

export(float) var velocity_multiplier = 200.0

var x: float = 0
var y: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect signals
	var e := connect("body_entered", self, "_on_body_entered")
	if e != 0:
		print(e)
	
	# determine starting direction
	randomize()
	x = rand_range(-1, 1)
	y = sqrt(1-pow(x,2))
#	randomize()
#	y = rand_range(-1, 1)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	linear_velocity.x = velocity_multiplier*x
	linear_velocity.y = velocity_multiplier*y
	rotation_degrees = 0
	pass

func _on_body_entered(body: Node) -> void:
	var groups: Array = body.get_groups()
	match groups[0]:
		"wall_top", "wall_bottom":
			y = -y
			pass
		"wall_right", "wall_left":
			x = -x
			pass
		_:
			if body.is_in_group("player"):
				x = -x
