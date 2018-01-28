extends Node2D

var obstacle_names = ['rock', 'rock_b']
var obstacles = []
var deco_names = ['bubble', 'fish']
var deco = []
var obstacle_script = preload('res://scripts/obstacle.gd')
var segment_count = 50
var lines = []
var time = 0

func _ready():
	obstacles = load_scenes('obstacles', obstacle_names)
	deco = load_scenes('deco', deco_names)
	set_process(true)

	var segment = {
		"height": Vector2(0, 150),
		"angle": 0,
		"position": Vector2(0, 0)
	}

	var divisor = 2
	for i in range(segment_count):
		spawn_segment(segment, divisor)
		segment = next_segment(segment)

	for i in range(10):
		spawn_segment(segment,divisor)
		segment = next_segment(segment)
		divisor += 0.25
		
	#femwhale does not reset right
	var femwhale_node = get_node("/root/World/femwhale")
	femwhale_node.set_script(obstacle_script)
	femwhale_node.set_pos(segment["position"] + get_pos())
	add_child(femwhale_node)

func reset():
	for child in get_children():
		child.reset()

func _process(dt):
	time += dt
		
	# for line in lines:
	# 	var angle = get_node('/root/World/player').player_angle
	# 	line[0] += Vector2(- 50 * dt, 0).rotated(angle)
	# 	line[1] += Vector2(- 50 * dt, 0).rotated(angle)
	# update()

func _draw():
	pass
	# for line in lines:
	# 	draw_line(line[0], line[1], Color(255, 255, 255))

func load_scenes(prefix, names):
	var scenes = []
	for name in names:
		var scene = load('res://scenes/' + prefix + '/' + name + '.tscn')
		scenes.append(scene)
	return scenes

func rand_element(arr):
	return arr[rand_range(0, arr.size())]

func prepare_node(scene):
	var node = Node2D.new()
	node.set_script(obstacle_script)
	node.add_child(scene.instance())
	return node

func next_segment(previous):
	var new_y = clamp(previous["height"].y + rand_range(-20, 20), 64, 144)
	var new_angle = clamp(previous["angle"] + rand_range(-PI/10, PI/10), -PI/4, PI/4)
	return {
		"height": Vector2(0, new_y),
		"position": previous["position"] + Vector2(10, rand_range(-5, 5)).rotated(new_angle),
		"angle": new_angle
	}

func spawn_wall_obstacle(segment, offset):
	var node = prepare_node(rand_element(obstacles))
	node.set_pos(segment["position"] + offset.rotated(segment["angle"]))
	node.maybe_add_deco()
	add_child(node)

func spawn_segment(segment, divisor):
	spawn_wall_obstacle(segment, -segment["height"] / divisor)
	spawn_wall_obstacle(segment, segment["height"] / divisor)
