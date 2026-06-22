extends Node2D

var is_mouse_hovering: bool = false

enum WheelType { MOUSE, RABBIT, FROG }
@export var wheel_type: WheelType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	is_mouse_hovering = true
	print("is hovered", is_mouse_hovering)


func _on_area_2d_mouse_exited() -> void:
	is_mouse_hovering = true
	print("is hovered", is_mouse_hovering)
