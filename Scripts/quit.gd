extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"../Start".grab_focus()

func _on_pressed() -> void:
	get_tree().quit()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
