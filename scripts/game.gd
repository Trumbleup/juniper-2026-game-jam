extends Node2D

var score: int
var serious_time_left: int = 30
var washerActive: bool = false
var animals
@export var totalPowerWeight: int = 10

@export var entityHeld: bool = false

@onready var mr_serious = $"Mr_ Serious"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	animals = get_tree().get_nodes_in_group("Animals")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handlePowerWeight()
	handleSeriousAppearance()


func _on_score_timer_timeout() -> void:
	if washerActive:
		score +=1
		$CanvasLayer/ScoreLabel.text = str(score) + " points"


func _on_washer_press(isActive: bool) -> void:
	washerActive = isActive
	
func _on_serious_timer_timeout() -> void:
	if serious_time_left == 0:
		return
	serious_time_left -= 1
	$CanvasLayer/SeriousTimeLabel.text = "Mr. Serious Appears in " + str(serious_time_left) + " Seconds"

func handlePowerWeight() -> void:
	var powerWeight: int
	for animal in animals:
		if animal.placedOnWheel:
			powerWeight += animal.score_weight
	totalPowerWeight = powerWeight
	$CanvasLayer/PowerLabel.text = str(totalPowerWeight) + "/10"
	
func handleSeriousAppearance() -> void:
	if serious_time_left != 0:
		return
	if mr_serious.visible:
		mr_serious.visible = false
	else:
		mr_serious.visible = true	
		
