extends KinematicBody2D

export var MAX_SPEED = 200
var ACCEL = 2000
var motion = Vector2.ZERO
var collected_memories = 0

signal died
signal collected_new_memory

onready var cam = $Camera2D

func play_animation(axis: Vector2) -> void:
	if axis.length() == 0:
		$AnimatedSprite.play('idle')
	elif axis.y < 0:
		change_animation('up')
	elif axis.y > 0:
		change_animation('down')
	elif axis.x > 0:
		change_animation('right')
		$AnimatedSprite.flip_h = false
	else:
		change_animation('left')
		$AnimatedSprite.flip_h = true
			
func change_animation(animation_name: String) -> void:
	if not $AnimatedSprite.animation == animation_name:
		$AnimatedSprite.play(animation_name)

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCEL * delta)
	else: 
		apply_movement(axis* ACCEL *delta)
	motion = move_and_slide(motion)
	play_animation(axis)


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
	emit_signal('collected_new_memory', collected_memories)
	mundo._are_memories_collected(collected_memories)
	
func _die():
	emit_signal("died")
