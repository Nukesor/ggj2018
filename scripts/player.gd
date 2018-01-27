extends KinematicBody2D

var player_angle = 0.0
var player_speed = 0.08
var player_radius = 4.0

var wave_radius = 120
var wave_origin

func _ready():
	wave_origin = get_node('/root/World/whale').get_pos()
	set_process(true)

func _draw():
	# Draw the player
#	draw_circle(wave_origin + Vector2(wave_radius, 0.0), player_radius, Color(1.0, 1.0, 1.0))
	draw_circle(Vector2(wave_radius, 0), player_radius, Color(1.0, 1.0, 1.0))

	# Add the collider
	get_node("CollisionShape2D").get_shape().set_radius(player_radius)

	set_pos(wave_origin)

func _process(delta):
	update()

	if Input.is_action_pressed("player_left") or Input.is_action_pressed("player_right"):
		if Input.is_action_pressed("player_left"):
			player_angle += player_speed

		elif Input.is_action_pressed("player_right"):
			player_angle -= player_speed

		#set_pos(wave_origin + Vector2(cos(player_angle), sin(player_angle)) * wave_radius)
		set_rot(player_angle)
