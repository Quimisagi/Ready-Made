extends Node

export var MEMORIES_TO_RECOVER = 4
var last_checkpoint: Vector2 = Vector2()
signal memories_completed

func _ready() -> void:
	if $Jugador:
		last_checkpoint = $Jugador.position
		if $LimitBottomLeft && $LimitBottomLeft:
			# Calcular limites para la cámara
			$Jugador/Camera2D.limit_bottom = $LimitBottomLeft.position.y
			$Jugador/Camera2D.limit_left = $LimitBottomLeft.position.x
			$Jugador/Camera2D.limit_right = $LimitTopRight.position.x
			$Jugador/Camera2D.limit_top = $LimitTopRight.position.y
		else:
			printerr('Se necesitan los nodos LimitBottomLeft y LimitTopRight para calcular los límites para la cámara')
	else:
		printerr('No hay un Jugador que sea hijo de esta escena')
	
	
func _are_memories_collected(var mem):
	print(mem)
	if mem == MEMORIES_TO_RECOVER:
		emit_signal("memories_completed")
		$Jugador/VictoryAudio.play()
		$Jugador.is_active = false
		yield(get_tree().create_timer(1), "timeout")
		AdministradorDeEscenas.go_to_next_scene()

func _on_Jugador_died(wait_time) -> void:
	yield(get_tree().create_timer(wait_time - 1), "timeout")
	$Jugador.position = last_checkpoint
	$Jugador.is_active = true

func _on_arrived_at_checkpoint(checkpoint_position:Vector2) -> void:
	last_checkpoint = checkpoint_position


func _on_arrived_at_checkpointt():
	pass # Replace with function body.
