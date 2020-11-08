extends KinematicBody2D

enum STATES {IDLE, ATTACKING, RETURNING_TO_ORIGIN}
var state: int = STATES.IDLE
var target: Node2D
export var speed: float = 100 #px/s
var initial_position: Vector2
var wasSpawned: bool = false

var movement_range = 50
var limitX = 250
var limitY = 250

func _ready() -> void:
	randomize()
	limitX = limitX + position.x
	limitY = limitY + position.y
	initial_position = position
	$IdleTimer.wait_time = rand_range(2, 6)
	
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
		
func _select_random_point():
	var randomVec = Vector2(rand_range(-movement_range, movement_range), rand_range(-movement_range, movement_range))
	var point = position + randomVec
	if point.x > limitX || point.x < -limitX || point.y > limitY || point.y < -limitY:
		point = null
	return point
		

func _prueba():
	var tween = get_node("Tween")
	var point = _select_random_point()
	if point != null:
		tween.interpolate_property(self, "position",
			position, _select_random_point(), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	
func _on_IdleTimer_timeout():
	_prueba()
	$IdleTimer.wait_time = rand_range(2, 6)
