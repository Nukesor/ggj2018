extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var player
var waveletscene

var	timer = 0
var	globaltimer = 0

var	circleradius = 0
var	finalwavedist = 0
var	finalradius = 100
var	wobble = 0
var wobblespeed = 10
var	waveangle = [45,135]

var	waveletspeed = 10
var waveletspawnrate = 0.5

func _draw():
	#draw_circle(player.get_pos(), circleradius, Color(255,255,255,1))
	# final wave
	draw_circle_arc(player.get_pos()+Vector2(finalwavedist,0), finalradius+wobble, waveangle[0], waveangle[1], Color(255,255,255,1))
	draw_circle_arc(player.get_pos()+Vector2(finalwavedist,0), finalradius+wobble-0.3, waveangle[0], waveangle[1], Color(255,255,255,0.5))
	draw_circle_arc(player.get_pos()+Vector2(finalwavedist,0), finalradius+wobble-0.5, waveangle[0], waveangle[1], Color(255,255,255,0.3))
	pass

func _process(delta):
	#circleradius += 0.2
	wobble = 2*sin(wobblespeed*globaltimer)
	print(wobble)
	timer += delta
	globaltimer += delta
	if timer > 1/waveletspawnrate:
		timer = 0
		#var node = waveletscene.instance(finalradius)
		var node = waveletscene.instance()
		node.set_radius(finalradius)
		node.set_waveangle(waveangle)
		node.set_speed(waveletspeed)
		add_child(node)
	update()
	pass

func draw_circle_arc( center, radius, angle_from, angle_to, color ):
    var nb_points = 32
    var points_arc = Vector2Array()

    for i in range(nb_points+1):
        var angle_point = angle_from + i*(angle_to-angle_from)/nb_points - 90
        var point = center + Vector2( cos(deg2rad(angle_point)), sin(deg2rad(angle_point)) ) * radius
        points_arc.push_back( point )

    for indexPoint in range(nb_points):
        draw_line(points_arc[indexPoint], points_arc[indexPoint+1], color)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("init wave")
	player = get_node("/root/World/whale")
	waveletscene = preload("res://scenes/Wavelet.tscn")
	set_process(true)
	pass
