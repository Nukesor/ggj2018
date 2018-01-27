extends KinematicBody2D

export var speed = 0.1

func _ready():
    set_process(true)

func _process(dt):
    translate(Vector2(-dt, 0))
