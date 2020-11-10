extends Path2D


onready var follow = $PathFollow2D
export var running = false
export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)

func _process(delta):
	if running:
		follow.set_offset(follow.get_offset() + speed * delta)


func _on_Area2D_body_entered(body):
	if body.is_in_group('player') && !running:
		running = true
		yield(get_tree().create_timer(5), "timeout")
		running = false
