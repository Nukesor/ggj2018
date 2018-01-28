extends Node2D

var deco_names = ['bubble', 'fish']
var scenes = []
var obstacle_script = preload('res://scripts/obstacle.gd')

func _ready():
	get_node('Timer').connect('timeout', self, 'maybe_spawn')
	for name in deco_names:
		scenes.append(load('res://scenes/deco/' + name + '.tscn'))

func rand_element(arr):
	return arr[rand_range(0, arr.size())]

func prepare_node(scene):
	var node = Node2D.new()
	node.set_script(obstacle_script)
	node.add_child(scene.instance())
	return node

func maybe_spawn():
	if randf() > 0.3:
		var node = prepare_node(rand_element(scenes))
		node.set_pos(Vector2(rand_range(-20, 20), rand_range(-100, 100)))
		add_child(node)
