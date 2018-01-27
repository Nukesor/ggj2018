extends KinematicBody2D

var angle = 0.0
var speed = 5.0
var radius = 50.0
var wave_origin = Vector2(125, 75)

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		var player_pos = get_pos()
		
		if Input.is_action_pressed("player_left"):
			angle -= speed
			
		elif Input.is_action_pressed("player_right"):
			angle += speed
		
		player_pos = wave_origin + Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))) * radius
		set_pos(player_pos)
		get_node("AnimatedSprite").set_rotd(-angle)