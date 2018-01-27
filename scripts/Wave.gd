extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var player
var circleradius
var timer
var finalwavedist
var finalradius
var waveangle
var waveletscene

func _draw():
	#draw_circle(player.get_pos(), circleradius, Color(255,255,255,1))
	# final wave
	draw_circle_arc(player.get_pos()+Vector2(finalwavedist,0), finalradius, waveangle[0], waveangle[1], Color(255,255,255,1))
	pass

func _process(delta):
	update()
	#circleradius += 0.2
	timer += 0.2
	if timer > 20:
		timer = 0
		#var node = waveletscene.instance(finalradius)
		var node = waveletscene.instance()
		node.set_radius(finalradius)
		node.set_waveangle(waveangle)
		add_child(node)

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
	player = get_node("/root/World/Player")
	waveletscene = preload("res://scenes/Wavelet.tscn")
	circleradius = 0
	finalwavedist = 0
	finalradius = 100
	timer = 0
	waveangle = [45,135]
	set_process(true)
	pass
