extends Node2D

var score: int
var serious_time_appearance: int = 30
var serious_time_leave: int = 3
var washerActive: bool = false
var animals
@export var totalPowerWeight: int = 10

@export var entityHeld: bool = false

@onready var mr_serious = $"Mr_ Serious"
@onready var serious_appearance_timer = $Timers/SeriousAppearanceTimer
@onready var serious_leave_timer = $Timers/SeriousLeaveTimer

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
	
func _on_serious_appearance_timer_timeout() -> void:
	if serious_time_appearance == 0 and serious_leave_timer.is_stopped():
		serious_appearance_timer.stop()
		serious_time_leave = 3
		serious_leave_timer.start()
		return
	serious_time_appearance -= 1
	$CanvasLayer/SeriousTimeLabel.text = "Mr. Serious Appears in " + str(serious_time_appearance) + " Seconds"

func _on_serious_leave_timer_timeout() -> void:
	if serious_time_leave == 0 and serious_appearance_timer.is_stopped():
		serious_leave_timer.stop()
		serious_time_appearance = 30
		serious_appearance_timer.start()
		return
	serious_time_leave -= 1
	
func handlePowerWeight() -> void:
	var powerWeight: int
	for animal in animals:
		if animal.placedOnWheel:
			powerWeight += animal.score_weight
	totalPowerWeight = powerWeight
	$CanvasLayer/PowerLabel.text = str(totalPowerWeight) + "/10"
	
func handleSeriousAppearance() -> void:
	if serious_leave_timer.is_stopped():
		mr_serious.visible = false	
	else:
		mr_serious.visible = true
		
		
		
