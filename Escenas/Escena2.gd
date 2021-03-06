extends Node

export var MEMORIES_TO_RECOVER = 6
var last_checkpoint: Vector2 = Vector2()
signal memories_completed

#func _ready() -> void:
#	last_checkpoint = $Jugador.position
#	# Calcular limites para la cámara
#	$Jugador/Camera2D.limit_bottom = $LimitBottomLeft.position.y
#	$Jugador/Camera2D.limit_left = $LimitBottomLeft.position.x
#	$Jugador/Camera2D.limit_right = $LimitTopRight.position.x
#	$Jugador/Camera2D.limit_top = $LimitTopRight.position.y
	
func _are_memories_collected(var mem):
	print(mem)
	if mem == MEMORIES_TO_RECOVER:
		emit_signal("memories_completed")
		$Jugador.is_active = false

#func _on_Jugador_died(wait_time) -> void:
#	yield(get_tree().create_timer(wait_time - 1), "timeout")
#	$Jugador.position = last_checkpoint
#	$Jugador.is_active = true

#func _on_Checkpoint_arrived_at_checkpoint(checkpoint_position:Vector2) -> void:
#	last_checkpoint = checkpoint_position


func _on_Jugador_collected_new_memory():
	pass # Replace with function body.
