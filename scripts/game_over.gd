extends Node2D

func end():
	get_node("/root/World/obstacle_spawner").reset()
	get_node("/root/World/whale").reset()
	get_node("/root/World/femwhale").reset()
	get_node("/root/World/player").reset()
	get_tree().set_pause(false)
	get_node("/root").remove_child(self)

func _enter_tree():
	if get_node("SamplePlayer"):
		get_node("SamplePlayer").play("dying_whale")
	if get_node("AnimationPlayer"):
		get_node("AnimationPlayer").play("game_over_animation")
	if find_node("Label"):
		var normal_speed = 100
		var max_speed = 1484
		var current_speed = OS.get_time_scale() * normal_speed
		var percentage = str(floor(100 * current_speed/max_speed))
		find_node("Label").set_text(percentage + '%')
	set_process_input(true)

func _input(event):
	if event.is_action_pressed('click') || event.is_action_pressed('ui_accept'):
		end()
