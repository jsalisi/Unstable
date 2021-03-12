extends Interactable

export (Resource) var locked_sound
onready var action_label = get_tree().get_root().find_node("ActionLabel", true ,false)

func get_interaction_text():
	return "Open Door"
	
func interact():
	action_label.set_text("Door Stuck")
	action_label.set_visible(true)
	var audio_node = AudioStreamPlayer.new()
	audio_node.stream = locked_sound
	audio_node.volume_db = 2
	audio_node.pitch_scale = rand_range(0.95, 1.05)
	add_child(audio_node)
	audio_node.play()
	yield(get_tree().create_timer(1), "timeout")
	audio_node.queue_free()
	action_label.set_visible(false)
