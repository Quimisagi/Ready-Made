extends KinematicBody2D

enum STATES {IDLE, ATTACKING, RETURNING_TO_ORIGIN}
var state: int = STATES.IDLE
var target: Node2D
var attack_range: float = 400
export var speed: float = 175 #px/s
var initial_position: Vector2
var wasSpawned: bool = false

func _ready() -> void:
	initial_position = global_position
	target = get_tree().get_nodes_in_group('player')[0]
	speed = speed + (randf()*50 - 25)
	
func change_to_attack_mode(target):
	self.target = target
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
					state = STATES.ATTACKING
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
