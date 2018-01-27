extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func end():
	print("STOP")

func _ready():
	get_node("TextureButton").connect("pressed", self, "end")
	get_node("AnimationPlayer").play("game_over_animation")
