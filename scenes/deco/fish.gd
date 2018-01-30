extends AnimatedSprite

func _ready():
	set_process(true)

func _process(dt):
	translate(Vector2(-20*dt, 0))
