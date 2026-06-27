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
		$Button.text = "Next"
	else:
		$Text1.visible = false
		$Text2.visible = true
		$Button.text = "Begin!"
	
func _on_button_pressed() -> void:
	if viewState == 0:
		viewState = 1
	else:
		get_tree().change_scene_to_file("res://scenes/game.tscn")
