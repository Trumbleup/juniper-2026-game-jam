extends Node2D

var hovering: bool = false
var dragging: bool = true
signal is_held(isDragging: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hovering:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			position = get_global_mouse_position()
			dragging = true
			is_held.emit(dragging)
		else:
			dragging = false
			is_held.emit(dragging)
			
	
	
func _on_area_2d_mouse_entered() -> void:
	hovering = true


func _on_area_2d_mouse_exited() -> void:
	hovering = false
