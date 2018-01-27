extends Node2D

export var speed = 50

var start_position

func _ready():
    set_process(true)
    start_position = get_pos()

func reset():
    set_pos(start_position)

func _process(dt):
    var angle = get_node('/root/World/player').player_angle
    translate(Vector2(- speed * dt, 0).rotated(angle))
