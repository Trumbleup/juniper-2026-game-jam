extends Node2D

var is_mouse_hovering: bool = false
var is_mouse_pressed: bool = false
signal press(isActive: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_mouse_hovering:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			is_mouse_pressed = true
			press.emit(true)
			print("pressed")
		else:
			is_mouse_pressed = false
			press.emit(false)
			print("not pressed")


func _on_area_2d_mouse_entered() -> void:
	is_mouse_hovering = true
	print("is hovered ", is_mouse_hovering)


func _on_area_2d_mouse_exited() -> void:
	is_mouse_hovering = false
	print("is hovered ", is_mouse_hovering)
