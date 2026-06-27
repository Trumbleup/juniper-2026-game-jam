extends Node2D

var is_mouse_hovering: bool = false
var animal_hovered: bool = false
var wheelType: String
var hoveredAnimal: CharacterBody2D = null
var wheelOccupied: bool
var occupiedAnimal: CharacterBody2D = null
@onready var game = $"../../.."
@onready var wheelTimer = $WheelTimer
@onready var serious_appearance_timer = $"../../../Timers/SeriousAppearanceTimer"

enum WheelType { MOUSE, RABBIT, FROG }
@export var wheel_type: WheelType

const SPAWN_WAIT_TIMES = {
	"mouse": [6.0, 8.0, 10.0, 12.0, 14.0, 16.0],
	"rabbit": [7.0, 11.0, 15.0, 18.0],
	"frog": [12.0, 18.0, 24.0],
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleWheelType()
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	wheelTimer.timeout.connect(_on_wheel_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if hoveredAnimal and !game.entityHeld:
		if !hoveredAnimal.placedOnWheel:
			handleAnimalPlacement(hoveredAnimal)
	
	if wheelOccupied:
		$AnimationPlayer.active = true
	else:
		$AnimationPlayer.active = false

func _on_wheel_timeout() -> void:
	if serious_appearance_timer.is_stopped():
		return
	if game.serious_time_appearance <= 2:
		return
	if occupiedAnimal:
		handleAnimalPlacement(occupiedAnimal)
		occupiedAnimal = null
		wheelOccupied = false
		hoveredAnimal = null

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
	if wheelOccupied or animal.animalType != wheelType:
		animal.handleAnimalGroundSpawn()
		hoveredAnimal = null
		return
	if animal.animalType == wheelType and !wheelOccupied:
		animal.handleAnimalPlacementWheel(global_position)
		wheelOccupied = true
		occupiedAnimal = animal
		wheelTimer.wait_time = SPAWN_WAIT_TIMES[animal.animalType].pick_random()
		wheelTimer.start()
		hoveredAnimal = null
		
