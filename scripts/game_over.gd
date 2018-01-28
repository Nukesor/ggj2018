extends Node2D

func end():
	get_node("/root/World/obstacle_spawner").reset()
	get_node("/root/World/whale").reset()
	get_node("/root/World/femwhale").reset()
	get_node("/root/World/player").reset()
	get_tree().set_pause(false)
	get_node("/root").remove_child(self)

func _ready():
	get_node("SamplePlayer").play("dying_whale")
	get_node("AnimationPlayer").play("game_over_animation")
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event.is_action_pressed('click') || event.is_action_pressed('ui_accept'):
		end()
