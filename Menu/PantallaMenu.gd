extends Control


var scene_path_to_load 

func _ready():
	for button in $Menu/FilaCentral/Botones.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	$ColorRect/AnimationPlayer.play("Fade")
	scene_path_to_load = scene_to_load

func change_scene():
	get_tree().change_scene(scene_path_to_load )
