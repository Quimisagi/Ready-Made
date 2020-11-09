extends KinematicBody2D

enum STATES {IDLE, ATTACKING, RETURNING_TO_ORIGIN}
var state: int = STATES.IDLE
var target: Node2D
var attack_range: float = 400
export var speed: float = 200 #px/s
var initial_position: Vector2
var wasSpawned: bool = false
var movement_range = 100

func _ready() -> void:
	randomize()
	$IdleTimer.wait_time = rand_range(2, 6)
	initial_position = global_position
	target = get_tree().get_nodes_in_group('player')[0]
	speed = speed + (randf()*50 - 25)
	
func change_to_attack_mode():
	$AudioStreamPlayer2D.play()
	state = STATES.ATTACKING

func stop_attacking():
	state = STATES.RETURNING_TO_ORIGIN
	
func follow_target(delta: float):
	var dir = (target.global_position - global_position).normalized()
	move_and_slide(dir * speed)
	
func return_to_origin(delta) -> bool:
	#TODO add logic
	var dir = (initial_position - global_position).normalized()
	move_and_slide(dir * speed)
	return global_position.distance_to(initial_position) < speed * delta
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match state:
		STATES.IDLE:
			if target:
				if target.global_position.distance_to(initial_position) < attack_range:
					change_to_attack_mode()
		STATES.ATTACKING:
			follow_target(delta)
			if initial_position.distance_to(global_position) > attack_range:
				state = STATES.RETURNING_TO_ORIGIN
		STATES.RETURNING_TO_ORIGIN:
			var arrived = return_to_origin(delta)
			if arrived:
				if wasSpawned:
					queue_free()
				else:
					state = STATES.IDLE
			
	
func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		body._die()
		
func _select_random_point():
	var randomPoint = Vector2(rand_range(initial_position.x -movement_range, initial_position.x + movement_range), rand_range(initial_position.y - movement_range, initial_position.y + movement_range))
	return randomPoint

func _tween():
	var tween = get_node("Tween")
	var point = _select_random_point()
	if point != null:
		tween.interpolate_property(self, "position",
			position, point, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	
func _on_IdleTimer_timeout():
	if state == STATES.IDLE:
		_tween()
	$IdleTimer.wait_time = rand_range(2, 6)
