extends Area2D

var shadows: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_AreaDeSombras_body_entered(body: Node) -> void:
	if body.is_in_group('player'):
		for shadow in shadows:
				shadow.change_to_attack_mode(body)
	elif body.is_in_group('shadows'):
		shadows.push_back(body)


func _on_AreaDeSombras_body_exited(body: Node) -> void:
	if body.is_in_group('player'):
		for shadow in shadows:
				shadow.stop_attacking()
