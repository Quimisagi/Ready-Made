extends ColorRect
var fadeIn = false
var speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if fadeIn:
		visible = true
		
		modulate.a += speed * delta
		
		if modulate.a >= 1 || modulate.a <= 0:
			fadeIn = false


func _on_Mundo_memories_completed():
	fadeIn = true
		
func _on_Jugador_died(wait_time):
	if !fadeIn:
		modulate.a = 0
		speed = 5
		fadeIn = true
		yield(get_tree().create_timer(wait_time / 2), "timeout")
		speed = -5
		fadeIn = true
