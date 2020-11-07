extends KinematicBody2D

var MAX_SPEED = 500
var ACCEL = 2000
var motion = Vector2.ZERO

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



func _on_RoomArea_area_entered(area):
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2


	cam.limit_top = collision_shape.global_position.y - size.y/2
	cam.limit_left = collision_shape.global_position.x - size.x/2

	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x



	


func _on_Cinematica_area_entered(area):
	cam.position.x = 100
