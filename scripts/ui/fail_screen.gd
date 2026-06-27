extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_retry_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_back_to_main_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/title.tscn")
