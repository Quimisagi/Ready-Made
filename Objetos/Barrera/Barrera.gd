extends StaticBody2D

export var memories_required: int = 0

func _on_Jugador_collected_new_memory(num_of_memories) -> void:
	if num_of_memories >= memories_required:
		$AnimationPlayer.play("FadeOut")
