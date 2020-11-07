extends Node2D

var MEMORIES_TO_RECOVER = 3

func _ready():
	pass # Replace with function body.
	
func _are_memories_collected(var mem):
	if mem == MEMORIES_TO_RECOVER:
		print("Sí xd")
