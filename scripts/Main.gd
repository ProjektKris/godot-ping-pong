extends Node2D

export(PackedScene) var ball_scene

# player1's score
var score1: int = 0

# player2's score
var score2: int = 0

var ball: RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ball = $Ball
	var e := $Ball.connect("out_of_bounds", self, "_on_Ball_out_of_bounds")
	if e != 0:
		print(e)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Ball_out_of_bounds(player: int) -> void:
	print("ball out of bounds")
	match player:
		1:
			score2 += 1
			$UI.call("update_score", 2, score2)
		2:
			score1 += 1
			$UI.call("update_score", 1, score1)
	
	# delete old ball
	ball.disconnect("out_of_bounds", self, "_on_Ball_out_of_bounds")
	ball.queue_free()

	# respawn ball
	ball = ball_scene.instance()
	call_deferred("add_child", ball)
	ball.position = Vector2(512, 300)

	var e := ball.connect("out_of_bounds", self, "_on_Ball_out_of_bounds")
	if e != 0:
		print(e)
	
	pass
