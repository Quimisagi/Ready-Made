extends Node2D

var MEMORIES_TO_RECOVER = 4
signal memories_completed

func _ready():
	pass
	
func _are_memories_collected(var mem):
	if mem == MEMORIES_TO_RECOVER:
		emit_signal("memories_completed")
