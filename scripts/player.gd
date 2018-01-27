extends KinematicBody2D

var player_angle = 0.0
var player_speed = 0.08
var player_radius = 4.0

var wave_radius = 120
var wave_origin

var go_scene = load("res://scenes/game_over.tscn")
var go_node = go_scene.instance()


func _ready():
	wave_origin = get_node('/root/World/whale').get_pos()
	set_process(true)
	set_fixed_process(true)
	
	# Set the position of the Area2D
	var area2D = get_node("Area2D")
	area2D.set_pos(Vector2(wave_radius, 0))
	area2D.connect('area_enter', self, 'collide')

func _draw():
	# Draw the player
	draw_circle(Vector2(wave_radius, 0), player_radius, Color(1.0, 1.0, 1.0))
	set_pos(wave_origin)

func _process(delta):
	update()

	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		if Input.is_action_pressed("player_left"):
			player_angle += player_speed

		elif Input.is_action_pressed("player_right"):
			player_angle -= player_speed

		set_rot(player_angle)

func collide(other):
	get_tree().set_pause(true)
	get_node("/root").add_child(go_node)
