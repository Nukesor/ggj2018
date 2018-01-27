extends KinematicBody2D

var player_angle = 0.0
var player_speed = 0.02
var player_radius = 4.0

var wave_radius = 120

var go_scene = load("res://scenes/game_over.tscn")
var go_node = go_scene.instance()


func _ready():
	set_process(true)
	set_fixed_process(true)

	# Set the position of the Area2D
	var area2D = get_node("Area2D")
	area2D.set_pos(Vector2(wave_radius, 0))
	area2D.connect('area_enter', self, 'collide')

	get_node("SamplePlayer").play("start_sound")
	get_node("SamplePlayer 2").play("water_background")

func _draw():
	# Draw the player
	draw_circle(Vector2(wave_radius, 0), player_radius, Color(1.0, 1.0, 1.0))

func _process(delta):
	update()

	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		if Input.is_action_pressed("player_left"):
			player_angle += player_speed

		elif Input.is_action_pressed("player_right"):
			player_angle -= player_speed

		set_rot(player_angle)

	var target_y = clamp(-Vector2(wave_radius, 0).rotated(player_angle).y, -40, 40)
	var viewport_y = get_viewport().get_canvas_transform().get_origin().y
	var new_y = lerp(viewport_y, target_y, 0.1)
	get_viewport().set_canvas_transform(Matrix32(0, Vector2(0, new_y)))

func collide(other):
	get_tree().set_pause(true)
	get_node("/root").add_child(go_node)
