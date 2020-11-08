extends ColorRect
var fadeIn = false
var speed = 1.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if fadeIn:
		visible = true
		
		modulate.a += speed * delta
		
		if modulate.a == 1:
			fadeIn = false


func _on_Mundo_memories_completed():
	fadeIn = true
