extends Node2D

var is_mouse_hovering: bool = false
var animal_hovered: bool = false
var wheelType: String
var hoveredAnimal: CharacterBody2D = null
@onready var game = $"../../"

enum WheelType { MOUSE, RABBIT, FROG }
@export var wheel_type: WheelType

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleWheelType()
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hoveredAnimal and !game.entityHeld:
		handleAnimalPlacement(hoveredAnimal)

func _on_area_2d_mouse_entered() -> void:
	is_mouse_hovering = true
	print("is hovered, wheel: ", wheelType)


func _on_area_2d_mouse_exited() -> void:
	is_mouse_hovering = false
	
func _on_body_entered(body: Node2D) -> void:
	print(body)
	if "animalType" in body:
		print("holding a ", body.animalType)
		animal_hovered = true
		hoveredAnimal = body
		
func _on_body_exited(body: Node2D) -> void:
	print(body)
	if "animalType" in body:
		print("animal leaving ", body.animalType)
		animal_hovered = false
		hoveredAnimal = null
	

func handleWheelType() -> void:
	match wheel_type:
		WheelType.MOUSE:
			wheelType = "mouse"
		WheelType.RABBIT:
			wheelType = "rabbit"
		WheelType.FROG:
			wheelType = "frog"
			
func handleAnimalPlacement(animal: CharacterBody2D) -> void:
		if animal.animalType == wheelType:
			animal.handleAnimalPlacementWheel(global_position)
		else:
			animal.handleAnimalGroundSpawn()
