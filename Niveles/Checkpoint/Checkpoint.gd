extends Area2D

signal arrived_at_checkpoint

func _ready() -> void:
	connect("body_entered", self, '_on_save_checkpoint')

func _on_save_checkpoint(body: Node):
	if body.is_in_group('player'):
		emit_signal('arrived_at_checkpoint', position)
