extends CanvasLayer

func update_score(player: int, score: int) -> void:
	match player:
		1:
			$Points1.text = String(score)
		2:
			$Points2.text = String(score)
	pass
