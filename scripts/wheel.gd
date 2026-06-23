extends Node2D

var is_mouse_hovering: bool = false
var wheelType: String

enum WheelType { MOUSE, RABBIT, FROG }
@export var wheel_type: WheelType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleWheelType()
	$Area2D.body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_mouse_entered() -> void:
	is_mouse_hovering = true
	print("is hovered, wheel: ", wheelType)


func _on_area_2d_mouse_exited() -> void:
	is_mouse_hovering = false
	
func _on_body_entered(body: Node2D) -> void:
	print(body)
	if "animalType" in body:
		print("holding a ", body.animalType)
	

func handleWheelType() -> void:
	match wheel_type:
		WheelType.MOUSE:
			wheelType = "mouse"
		WheelType.RABBIT:
			wheelType = "rabbit"
		WheelType.FROG:
			wheelType = "frog"
