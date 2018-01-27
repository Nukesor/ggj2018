extends Node2D

var obstacle_names = ['rock', 'coral']
var obstacles = []
var obstacle_script = preload('res://scripts/obstacle.gd')

func _ready():
	var timer = get_node('timer')
	timer.connect('timeout', self, 'timeout')
	set_process(true)
	for name in obstacle_names:
		var scene = load('res://scenes/obstacles/' + name + '.tscn')
		obstacles.append(scene)

func _process(dt):
	pass

func timeout():
	var scene = obstacles[rand_range(0, obstacles.size())]
	var node = scene.instance()
	node.set_script(obstacle_script)
	add_child(node)
