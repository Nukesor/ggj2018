extends Node2D

func end():
	get_node("/root/World/obstacle_spawner").reset()
	get_node("/root/World/whale").reset()
	get_node("/root/World/player").reset()
	get_tree().set_pause(false)
	get_node("/root").remove_child(self)

func _ready():
	get_node("TextureButton").connect("pressed", self, "end")
	get_node("SamplePlayer").play("dying_whale")
	get_node("AnimationPlayer").play("game_over_animation")
