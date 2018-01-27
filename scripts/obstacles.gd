extends Node2D

var obstacle_names = ['rock', 'coral']
var obstacles = []
var obstacle_script = preload('res://scripts/obstacle.gd')
var deco_names = ['bubble', 'fish']
var deco = []

func _ready():
	var timer = get_node('timer')
	timer.connect('timeout', self, 'timeout')
	obstacles = load_scenes('obstacles', obstacle_names)
	deco = load_scenes('deco', deco_names)

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

func timeout():
	var scene = rand_element(obstacles)
	add_child(prepare_node(scene))

	if randf() > 0.8:
		var node = prepare_node(rand_element(deco))
		node.set_pos(Vector2(rand_range(-50, 50), rand_range(-50, 100)))
		add_child(node)
