extends Button
class_name toMainButton

func _ready() -> void:
	$".".grab_focus()
	

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
