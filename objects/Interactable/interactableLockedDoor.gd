extends Interactable

export (Resource) var locked_sound

#onready var interaction_label = get_tree().get_root().find_node("InteractionLabel", true ,false)

func get_interaction_text():
	return "Open Door"
	
func interact():
	var interaction_label = get_tree().get_root().find_node("InteractionLabel", true ,false)
	interaction_label.set_text("Door stuck")
	print("Door stuck")
	interaction_label.set_visible(true)
	
	var audio_node = AudioStreamPlayer.new()
	audio_node.stream = locked_sound
	audio_node.volume_db = 2
	audio_node.pitch_scale = rand_range(0.95, 1.05)
	add_child(audio_node)
	audio_node.play()
	yield(get_tree().create_timer(1), "timeout")
	audio_node.queue_free()
