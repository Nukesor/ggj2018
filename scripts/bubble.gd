extends Sprite

var speed = 5 + randf() * 20

func _ready():
	set_frame(rand_range(0, get_hframes()))
	set_process(true)

func _process(dt):
	translate(Vector2(0, - speed * dt))
