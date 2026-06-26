class_name Animal
extends CharacterBody2D

var direction = -1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var sprite_2D: Sprite2D = $Pivot/Sprite2D
@onready var animation_player: AnimationPlayer = $Pivot/AnimationPlayer

var hovering: bool = false
var dragging: bool = false
var animalType: String
var placedOnWheel: bool
var isOnGround: bool
var isHoveredOverWheel: bool
@onready var game = $"../../"
@onready var ground = $"../../Ground"
@onready var serious_appearance_timer = $"../../Timers/SeriousAppearanceTimer"

# Create a dropdown list for the Inspector
enum AnimalType { MOUSE, RABBIT, FROG }
@export var animal_type: AnimalType

@onready var grabZone = $GrabZone
@onready var wheelTimer = $WheelTimer

var delay = 2

var mouse_spawns = [{"x": 1275, "y": 952}, {"x": 1283, "y": 1027}]
var rabbit_spawns = [{"x": 1467, "y": 885 }, {"x": 1495, "y": 973}]
var frog_spawns = [{"x": 1721, "y": 1019 }, {"x": 1704, "y": 929}]

const SPAWN_WAIT_TIMES = {
	"mouse": [6.0, 8.0, 10.0, 12.0, 14.0, 16.0],
	"rabbit": [7.0, 11.0, 15.0, 18.0],
	"frog": [12.0, 18.0, 24.0],
	}
	
func _physics_process(delta):
	if dragging == true:
		animation_player.current_animation = str(animalType) + "_idle"
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "position", get_global_mouse_position(), delta * delay)
		global_position = get_global_mouse_position()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleAnimalType()
	grabZone.mouse_entered.connect(_on_grabzone_mouse_entered)
	grabZone.mouse_exited.connect(_on_grabzone_mouse_exited)
	wheelTimer.timeout.connect(_on_wheel_timeout)
	wheelTimer.wait_time = SPAWN_WAIT_TIMES[animalType].pick_random()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and !placedOnWheel and hovering:
		if event.pressed:
			get_viewport().set_input_as_handled()
			game.entityHeld = true
			dragging = true
		else:
			print("happens")
			game.entityHeld = false
			dragging = false
			animation_player.current_animation = str(animalType) + "_run"
			if !isOnGround and !isHoveredOverWheel:
				print("fires")
				handleAnimalGroundSpawn()
			

func _on_grabzone_mouse_entered() -> void:
	hovering = true


func _on_grabzone_mouse_exited() -> void:
	hovering = false
	
func _on_wheel_timeout() -> void:
	if serious_appearance_timer.is_stopped():
		return
	handleAnimalGroundSpawn()
	
func handleMovement(delta: float, speed) -> void:
	if placedOnWheel:
		return
	if ray_cast_right.is_colliding():
		direction = -1
		sprite_2D.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		sprite_2D.flip_h = true
	position.x += direction * speed * delta
	move_and_slide()
	
func handleAnimalType() -> void:
	match animal_type:
		AnimalType.MOUSE:
			animalType = "mouse"
		AnimalType.RABBIT:
			animalType = "rabbit"
		AnimalType.FROG:
			animalType = "frog"
			
func handleAnimalGroundSpawn() -> void:
	if !wheelTimer.is_stopped():
		wheelTimer.stop()
	match animalType:
		"mouse":
			var spawnPoint = mouse_spawns.pick_random()
			global_position = Vector2(spawnPoint["x"], spawnPoint["y"])
		"rabbit":
			var spawnPoint = rabbit_spawns.pick_random()
			global_position = Vector2(spawnPoint["x"], spawnPoint["y"])
		"frog":
			var spawnPoint = frog_spawns.pick_random()
			global_position = Vector2(spawnPoint["x"], spawnPoint["y"])
	placedOnWheel = false
	
			
func handleAnimalPlacementWheel(wheelPosition: Vector2) -> void:
	placedOnWheel = true
	global_position = wheelPosition
	sprite_2D.flip_h = false
	wheelTimer.wait_time = SPAWN_WAIT_TIMES[animalType].pick_random()
	wheelTimer.start()
	

		
		
	
	
