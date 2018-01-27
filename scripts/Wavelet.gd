extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var circleradius
var waveangle
var speed
var wave_origin

func _draw():
	draw_circle_arc(wave_origin, circleradius, waveangle[0]-180, waveangle[1]-180, Color(255,255,255,circleradius/100))
	pass

func _process(delta):
	update()
	circleradius -= speed*delta
	if circleradius < 0 :
		self.queue_free()
	pass

func draw_circle_arc( center, radius, angle_from, angle_to, color ):
    var nb_points = 32
    var points_arc = Vector2Array()

    for i in range(nb_points+1):
        var angle_point = angle_from + i*(angle_to-angle_from)/nb_points - 90
        var point = center + Vector2( sin(deg2rad(angle_point)), cos(deg2rad(angle_point)) ) * radius
        points_arc.push_back( point )

    for indexPoint in range(nb_points):
        draw_line(points_arc[indexPoint], points_arc[indexPoint+1], color)

func set_radius(radius):
	circleradius = radius

func set_waveangle(angletuple):
	waveangle = angletuple

func set_speed(waveletspeed):
	speed = waveletspeed

func set_origin(origin):
	wave_origin = origin

func _ready():
	#print("init wavelet")
	set_process(true)
	pass
