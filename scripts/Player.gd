extends StaticBody2D

export(bool) var player1 = true
export(float) var velocity = 400.0

var up := false
var down := false

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if up:
		if position.y > 50:
			position.y -= velocity * delta
	if down:
		if position.y < 550:
			position.y += velocity * delta 
	pass

# Called when the client inputs
func _input(event: InputEvent) -> void:
	var player_id = "1" if player1 else "2"
	if event.is_action_pressed("player" + player_id + "_up"):
		up = true
	elif event.is_action_pressed("player" + player_id + "_down"):
		down = true
	elif event.is_action_released("player" + player_id + "_up"):
		up = false
	elif event.is_action_released("player" + player_id + "_down"):
		down = false
	pass
