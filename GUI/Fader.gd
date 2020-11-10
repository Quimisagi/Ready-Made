extends ColorRect
var fadeIn = false
export var fadeOut = false
var speed = 5

func _process(delta):
	if fadeIn:
		visible = true
		
		modulate.a += speed * delta
		
		if modulate.a >= 1 || modulate.a <= 0:
			fadeIn = false
			
	if fadeOut:
		modulate.a -= delta
		if modulate.a <= 0:
			fadeOut = false
			visible = false

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
