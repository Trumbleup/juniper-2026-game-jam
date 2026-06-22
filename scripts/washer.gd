extends Node2D

var is_mouse_hovering: bool = false
var is_mouse_pressed: bool = false
var can_press: bool = true
signal press(isActive: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if can_press:
		if is_mouse_hovering:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				is_mouse_pressed = true
				press.emit(true)
			else:
				is_mouse_pressed = false
				press.emit(false)
		else:
			is_mouse_pressed = false # ensures player cannot leave washer while pressing and keep score going
			press.emit(false)


func _on_area_2d_mouse_entered() -> void:
	is_mouse_hovering = true


func _on_area_2d_mouse_exited() -> void:
	is_mouse_hovering = false


func _on_animal_is_held(isDragging: bool) -> void:
	can_press = !isDragging
