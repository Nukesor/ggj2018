extends KinematicBody2D

export var speed = 10

func _ready():
    set_process(true)

func _process(dt):
    var angle = get_node('/root/World/player').player_angle
    translate(Vector2(-1, 0).rotated(angle))
