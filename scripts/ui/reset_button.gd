extends Button


func _ready() -> void:
	visible = false

func _on_pressed() -> void:
	get_tree().reload_current_scene()
