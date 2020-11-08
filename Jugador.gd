extends KinematicBody2D

export var MAX_SPEED = 200
var ACCEL = 2000
var motion = Vector2.ZERO
var collected_memories = 0
signal died

onready var cam = $Camera2D


func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCEL * delta)
	else: 
		apply_movement(axis* ACCEL *delta)
	motion = move_and_slide(motion)


func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return axis.normalized()

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount  
	else:
		motion = Vector2.ZERO

func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)

	
func _on_Cinematica_area_entered(area):
	cam.position.x = 100
	
func _check_if_memories_completed():
	var mundo = get_tree().get_root().get_node("Mundo")
	mundo._are_memories_collected(collected_memories)
	
func _die():
	emit_signal("died")
