extends Node

var scenes = [
	'res://Escenas/Escena1.tscn',
	'res://Escenas/Escena2.tscn',
	'res://Escenas/Escena3.tscn',
]

var game_over_scene = 'res://Menu/GameOver.tscn'

var currentScene = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func go_to_next_scene():
	if currentScene < scenes.size():
		currentScene+=1
		var new_scene = scenes[currentScene]
		get_tree().change_scene(new_scene)
	else:
		get_tree().change_scene(game_over_scene)
