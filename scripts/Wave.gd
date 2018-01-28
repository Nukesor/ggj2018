extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var waveletscene
var player

var	timer = 0
var	globaltimer = 0

var	circleradius = 0
var	finalwavedist = 0
var	finalradius
var	wobble = 0
var wobblespeed = 15
var wavelength = 60
# var	waveangle = [-30,-30+wavelength]
var	waveangle = 30
var waveangletolerance = 15
var rotate_acceleration = 15
var rotate_minspeed = 100
var rotatespeed

var	waveletspeed = 60
var waveletspawnrate = 2.0
var wave_origin
var player_rot
var player_rot_deg

func _draw():
	# final wave
	draw_circle_arc(wave_origin, finalradius+wobble, waveangle, waveangle+wavelength, Color(255,255,255,1))
	# draw_circle_arc(wave_origin, finalradius+wobble, 90, 180, Color(0,0,0,1))
	draw_circle_arc(wave_origin, finalradius+wobble-0.3, waveangle, waveangle+wavelength, Color(255,255,255,0.5))
	draw_circle_arc(wave_origin, finalradius+wobble-0.5, waveangle, waveangle+wavelength, Color(255,255,255,0.3))
	# draw_circle_arc(wave_origin+Vector2(100,0), finalradius+wobble-0.5, 270, 420, Color(0,0,0,0.3))
	# draw_circle_arc(wave_origin+Vector2(100,0), finalradius+wobble-0.5, 0, -60, Color(255,255,255,0.3))
	pass

func _process(delta):
	#circleradius += 0.2
	player_rot = player.get_global_rot()
	player_rot_deg = rad2deg(player_rot)
	# print(player_rot_deg)
	player_rot_deg += 180
	# print(waveangle)
	# waveangle[1] = rad2deg(player_rot) - wavelength/2
	# waveangle[0] = rad2deg(player_rot) + wavelength/2
	if waveangle < fmod(waveangle+wavelength,360):
		# print("checking")
		if player_rot_deg < fmod(waveangle+waveangletolerance, 360) and player_rot_deg < fmod(waveangle+wavelength-waveangletolerance, 360):
			# or ( (player_rot_deg > waveangle[0]+waveangletolerance+180) and (player_rot_deg - waveangle[0]) > 180 ):
			rotatespeed = max(rotate_minspeed, min(10, abs(rad2deg(player_rot) - waveangle))*rotate_acceleration)

			waveangle -= delta*rotatespeed
			if waveangle < 0:
				waveangle += 360

			# waveangle[0] = fmod(waveangle[0] + 180 - delta*rotatespeed, 360) - 180
			# waveangle[1] = fmod(waveangle[1] + 180 - delta*rotatespeed, 360) - 180

			# print("rotating right")
			# print(waveangle)

		elif player_rot_deg > fmod(waveangle+wavelength-waveangletolerance,360) and player_rot_deg > fmod(waveangle+waveangletolerance,360):
			# or ( (player_rot_deg < waveangle[1]+waveangletolerance-180) and (waveangle[1] - player_rot_deg) > 180 ):
			rotatespeed = max(rotate_minspeed, min(10, abs(rad2deg(player_rot) - waveangle+wavelength))*rotate_acceleration)

			waveangle += delta*rotatespeed
			if waveangle > 360:
				waveangle -= 360

			# waveangle[0] = fmod(waveangle[0] + 180 + delta*rotatespeed, 360) - 180
			# waveangle[1] = fmod(waveangle[1] + 180 + delta*rotatespeed, 360) - 180

			# print("rotating left")
			# print(waveangle)
			# print("rotation")
			# print(rad2deg(player_rot))
			# print("angle")
			# print(waveangle)
		# else:
			# print("ok")
	else:
		if player_rot_deg < fmod(waveangle+wavelength,360) and player_rot_deg < fmod(wavelength+waveangletolerance,360):
			# print("should rot left")
			waveangle += delta*rotatespeed
		elif player_rot_deg :
			# print("should rot right")
			waveangle -= delta*rotatespeed

	wobble = 2*sin(wobblespeed*globaltimer)
	timer += delta
	globaltimer += delta
	if timer > 1/waveletspawnrate:
		timer = 0
		#var node = waveletscene.instance(finalradius)
		var node = waveletscene.instance()
		node.set_radius(finalradius)
		node.set_waveangle([waveangle+180,waveangle+wavelength+180])
		node.set_speed(waveletspeed)
		node.set_origin(wave_origin)
		node.set_pos(get_global_pos())
		node.set_rot(get_global_rot())
		get_node('/root/World').add_child(node)
	# print("wo")
	# print(wave_origin)
	# print("pp")
	# print(get_node('/root/World/player').get_pos())
	update()

func draw_circle_arc( center, radius, angle_from, angle_to, color ):
    var nb_points = 32
    var points_arc = Vector2Array()

    for i in range(nb_points+1):
        var angle_point = angle_from + i*(angle_to-angle_from)/nb_points - 90
        var point = center + Vector2( sin(deg2rad(angle_point)), cos(deg2rad(angle_point)) ) * radius
        points_arc.push_back( point )

    for indexPoint in range(nb_points):
        draw_line(points_arc[indexPoint], points_arc[indexPoint+1], color)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("init wave")
	player = get_node('/root/World/player')
	waveletscene = preload("res://scenes/Wavelet.tscn")
	finalradius = player.wave_radius
	# finalradius = 19
	wave_origin = get_node('/root/World/player').get_global_pos()
	set_process(true)
