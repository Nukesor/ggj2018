extends ParallaxBackground
const MAX_SCROLLSPEED = 20

var max_z_index = 1

func _ready():
	set_process(true)
	
	for layer in get_children():
		if layer.get_z() > max_z_index:
			max_z_index = layer.get_z()

func _process(delta):
	var angle = get_node('/root/World/player').player_angle
	
	for layer in get_children():
		var z_index = layer.get_z()
		
		layer.translate(Vector2(-MAX_SCROLLSPEED * ((float(z_index) / max_z_index) + 0.2) * delta, 0).rotated(angle))
