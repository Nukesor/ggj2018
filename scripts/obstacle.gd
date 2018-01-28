extends Node2D

export var speed = 50

var start_position
var deco_names = ['coral', 'algae']

func rand_element(arr):
	return arr[rand_range(0, arr.size())]

func _ready():
    set_process(true)
    start_position = get_pos()

    if randf() > 0.2:
        var node = load('res://scenes/obstacles/' + rand_element(deco_names) + '.tscn').instance()
        var x = rand_range(-15, 15)
        var y = rand_range(-15, 15)
        node.set_pos(Vector2(x, y))
        var brightness = rand_range(0.8, 1.1)
        node.set_modulate(Color(brightness, brightness, brightness))
        if randf() > 0.5:
            node.set_scale(Vector2(-1.0, 1))
        add_child(node)

func reset():
    set_pos(start_position)

func _process(dt):
    var angle = get_node('/root/World/player').player_angle
    translate(Vector2(- speed * dt, 0).rotated(angle))
