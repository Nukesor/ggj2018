extends Node2D

export var speed = 50

func _ready():
    set_process(true)

func _process(dt):
    var angle = get_node('/root/World/player').player_angle
    translate(Vector2(- speed * dt, 0).rotated(angle))
