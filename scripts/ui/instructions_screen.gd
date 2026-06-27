extends Control

var viewState: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if viewState == 0:
		$Text1.visible = true
		$Text2.visible = false
	else:
		$Text1.visible = false
		$Text2.visible = true


func _on_next_button_pressed() -> void:
	if viewState == 0:
		viewState = 1
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_previous_button_pressed() -> void:
	if viewState == 1:
		viewState = 0
	else:
		get_tree().change_scene_to_file("res://scenes/ui/title.tscn")
