class_name Animal
extends Node2D

var hovering: bool = false
var dragging: bool = false
var animalType: String
@onready var game = $"../../"

# Create a dropdown list for the Inspector
enum AnimalType { MOUSE, RABBIT, FROG }
@export var animal_type: AnimalType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleAnimalType()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		handleDragging()
			
	
	
func _on_area_2d_mouse_entered() -> void:
	hovering = true
	print(animalType)


func _on_area_2d_mouse_exited() -> void:
	hovering = false

func handleDragging() -> void:
	if hovering:
		if game.entityHeld == true and dragging == false:
			return 
		else:
			if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				position = get_global_mouse_position()
				dragging = true
				game.entityHeld = true
			else:
				dragging = false
				game.entityHeld = false	
	
func handleAnimalType() -> void:
	match animal_type:
		AnimalType.MOUSE:
			animalType = "mouse"
		AnimalType.RABBIT:
			animalType = "rabbit"
		AnimalType.FROG:
			animalType = "frog"
