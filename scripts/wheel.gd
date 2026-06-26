extends Node2D

var is_mouse_hovering: bool = false
var animal_hovered: bool = false
var wheelType: String
var hoveredAnimal: CharacterBody2D = null
var wheelOccupied: bool
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
	if !hoveredAnimal:
		wheelOccupied = false
	
	if hoveredAnimal and !game.entityHeld and !wheelOccupied:
		if !hoveredAnimal.placedOnWheel:
			handleAnimalPlacement(hoveredAnimal)

func _on_area_2d_mouse_entered() -> void:
	is_mouse_hovering = true


func _on_area_2d_mouse_exited() -> void:
	is_mouse_hovering = false
	
func _on_body_entered(body: Node2D) -> void:
	if "animalType" in body:
		body.isHoveredOverWheel = true
		animal_hovered = true
		hoveredAnimal = body
		
func _on_body_exited(body: Node2D) -> void:
	if "animalType" in body:
		body.isHoveredOverWheel = false
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
			wheelOccupied = true
		else:
			animal.handleAnimalGroundSpawn()
			wheelOccupied = false
