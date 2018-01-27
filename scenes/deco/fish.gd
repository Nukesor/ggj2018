extends AnimatedSprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	
func _process(dt):
	translate(Vector2(-10*dt, 0))
