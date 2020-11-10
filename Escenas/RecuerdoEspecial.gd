extends Node2D

var obtained = false

func _on_PlayerDetector_body_entered(body):
	if body.is_in_group('player') && !obtained:
		obtained = true
		body.collected_memories += 1
		body._check_if_memories_completed()
		$esfera/AnimationPlayer.play("disappear")
		$AudioStreamPlayer2D.play()
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()
