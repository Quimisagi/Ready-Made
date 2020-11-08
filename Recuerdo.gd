extends Node2D

var t = 0;
var points_array = []
var min_speed = 0.3
var max_speed = 0.15
var speed = 0
var active = true
<<<<<<< Updated upstream
var movement_range = 350
var limitX = 1200
var limitY = 400
=======
var movement_range = 300
var limitX = 600
var limitY = 350
>>>>>>> Stashed changes
var min_points = 6
var max_points = 15


# Called when the node enters the scene tree for the first time.
func _ready():
	limitX = limitX + position.x
	limitY = limitY + position.y
	randomize()
	
func _process(delta):
	_follow_random_curve_path(delta)
	
func _on_PlayerDetector_body_entered(body):
	if body.is_in_group('player'):
		body.collected_memories += 1
		body._check_if_memories_completed()
		queue_free()

func _make_interpolations(points_array: Array, t: float):
	var interpolations_array = []
	for i in (points_array.size() - 1):
		var interpolation = lerp(points_array[i], points_array[i + 1], t)
		interpolations_array.append(interpolation)
	return interpolations_array;   
	
func _select_random_points():
	var points_number = rand_range(min_points, max_points)
	var array = []
	array.append(position)
	for i in range(array.size(), points_number + 1):
		var point = generate_point_within_the_limit()
		_prueba(point)
		array.append(point)
	return array
	
func generate_point_within_the_limit():
	var randomVec = Vector2(rand_range(-movement_range, movement_range), rand_range(-movement_range, movement_range))
	var point = position + randomVec
<<<<<<< Updated upstream
	while point.x > limitX || point.x < -limitX || point.y > limitY || point.y < -limitY:
=======
	var xd = _prueba(point)
	while xd:
>>>>>>> Stashed changes
		randomVec = Vector2(rand_range(-movement_range, movement_range), rand_range(-movement_range, movement_range))
		point = position + randomVec
		xd = _prueba(point)
	return point

func _get_point_of_curve_path(points_array: Array, t: float):
	var array = points_array
	while array.size() > 1:
		array = _make_interpolations(array, t)
	return array[0]
	
func _follow_random_curve_path(delta):
	if active:
		if t >= 1:
			t = 0
		if t == 0:
			points_array = _select_random_points()
			speed = rand_range(min_speed, max_speed)
		position = _get_point_of_curve_path(points_array, t)
		t += speed * delta
	

func _prueba(point):
	pass
	#var space = get_world_2d().get_direct_space_state()
	#var results = space.intersect_point(point, 32, [], 2147483647, false, true)
	#if results.size() > 0:
	#	for dictionarie in results:
	#		if dictionarie.collider.is_in_group('wall'):
	#			print("Entró")
	#			return true
	#return false
		



func _on_Area2D_body_entered(body):
	print("Se paró")
	active = false
