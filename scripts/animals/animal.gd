class_name Animal
extends CharacterBody2D

var hovering: bool = false
var dragging: bool = false
var animalType: String
@onready var game = $"../../"

# Create a dropdown list for the Inspector
enum AnimalType { MOUSE, RABBIT, FROG }
@export var animal_type: AnimalType

@onready var grabZone = $GrabZone

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleAnimalType()
	grabZone.mouse_entered.connect(_on_grabzone_mouse_entered)
	grabZone.mouse_exited.connect(_on_grabzone_mouse_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		handleDragging()
			
	
	
func _on_grabzone_mouse_entered() -> void:
	hovering = true
	print(animalType)


func _on_grabzone_mouse_exited() -> void:
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
			
func handleAnimalGroundSpawn() -> void:
	var MOUSE_SPAWNS = [{"x": 1275, "y": 952}, {"x": 1283, "y": 1027}]
	var RABBIT_SPAWNS = [{"x": 1467, "y": 885 }, {"x": 1495, "y": 973}]
	var FROG_SPAWNS = [{"x": 1721, "y": 1019 }, {"x": 1704, "y": 929}]
	print(animalType)
	match animalType:
		"mouse":
			var spawnPoint = MOUSE_SPAWNS.pick_random()
			global_position = Vector2(spawnPoint["x"], spawnPoint["y"])
		"rabbit":
			var spawnPoint = RABBIT_SPAWNS.pick_random()
			global_position = Vector2(spawnPoint["x"], spawnPoint["y"])
		"frog":
			var spawnPoint = FROG_SPAWNS.pick_random()
			global_position = Vector2(spawnPoint["x"], spawnPoint["y"])
			
func handleAnimalPlacementWheel(wheelPosition: Vector2) -> void:
	global_position = wheelPosition
	
	
