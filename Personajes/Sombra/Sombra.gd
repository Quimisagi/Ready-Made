extends KinematicBody2D

enum STATES {IDLE, ATTACKING, RETURNING_TO_ORIGIN}
var state: int = STATES.IDLE
var target: Node2D
export var speed: float = 100 #px/s
var initial_position: Vector2
var wasSpawned: bool = false

func _ready() -> void:
	initial_position = position
	
func change_to_attack_mode(target):
	self.target = target
	state = STATES.ATTACKING

func stop_attacking():
	state = STATES.RETURNING_TO_ORIGIN
	
func follow_target(delta: float):
	var dir = (target.global_position - global_position).normalized()
	move_and_slide(dir * speed)
	
func return_to_origin() -> bool:
	#TODO add logic
	return position.is_equal_approx(initial_position)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match state:
		STATES.IDLE:
			# TODO: Make the shadow wander
			pass
		STATES.ATTACKING:
			follow_target(delta)
		STATES.RETURNING_TO_ORIGIN:
			var arrived = return_to_origin()
			if arrived:
				if wasSpawned:
					queue_free()
				else:
					state = STATES.IDLE
			



func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		body._die()
