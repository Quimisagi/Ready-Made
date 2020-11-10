extends StaticBody2D

export var memories_required: int = 0

func _ready():
	var jugador = get_tree().get_root().get_node("Mundo").get_node("Jugador")
	jugador.connect("collected_new_memory", self, "_on_Jugador_collected_new_memory" )

func _on_Jugador_collected_new_memory(num_of_memories) -> void:
	if num_of_memories >= memories_required:
		$AnimationPlayer.play("FadeOut")

func _on_Area2D_body_entered(body):
	if body.is_in_group('memory'):
		$AnimationPlayer.play("FadeOut")
