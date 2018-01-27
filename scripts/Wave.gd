extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var waveletscene

var	timer = 0
var	globaltimer = 0

var	circleradius = 0
var	finalwavedist = 0
var	finalradius
var	wobble = 0
var wobblespeed = 15
var	waveangle = [60,120]

var	waveletspeed = 60
var waveletspawnrate = 2.0

func _draw():
	# final wave
	draw_circle_arc(Vector2(finalwavedist,0), finalradius+wobble, waveangle[0], waveangle[1], Color(255,255,255,1))
	draw_circle_arc(Vector2(finalwavedist,0), finalradius+wobble-0.3, waveangle[0], waveangle[1], Color(255,255,255,0.5))
	draw_circle_arc(Vector2(finalwavedist,0), finalradius+wobble-0.5, waveangle[0], waveangle[1], Color(255,255,255,0.3))
	pass

func _process(delta):
	#circleradius += 0.2
	wobble = 2*sin(wobblespeed*globaltimer)
	timer += delta
	globaltimer += delta
	if timer > 1/waveletspawnrate:
		timer = 0
		#var node = waveletscene.instance(finalradius)
		var node = waveletscene.instance()
		node.set_radius(finalradius)
		node.set_waveangle(waveangle)
		node.set_speed(waveletspeed)
		node.set_pos(get_global_pos())
		node.set_rot(get_global_rot())
		get_node('/root/World').add_child(node)
	update()

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
	waveletscene = preload("res://scenes/Wavelet.tscn")
	finalradius = get_parent().wave_radius
	set_process(true)
