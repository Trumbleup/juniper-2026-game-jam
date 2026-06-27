extends Node2D

var score: int
var serious_time_appearance: int = 30
var serious_time_leave: int = 3
var game_time_in_seconds: int = 120
var washerActive: bool = false
var animals
@export var totalPowerWeight: int = 10

@export var entityHeld: bool = false

@onready var mr_serious = $"Mr_ Serious"
@onready var serious_appearance_timer = $Timers/SeriousAppearanceTimer
@onready var serious_leave_timer = $Timers/SeriousLeaveTimer
@onready var reset_button = $CanvasLayer/ResetButton
@onready var cursor = $Entities/Cursor

signal spin_washer(is_active: bool)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	animals = get_tree().get_nodes_in_group("Animals")
	 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	handlePowerWeight()
	handleSeriousAppearance()
	handleLose()
	handleGameTime()
	
	if washerActive:
		spin_washer.emit(true)
	else:
		spin_washer.emit(false)

func _on_game_timer_timeout() -> void:
	game_time_in_seconds -= 1

func _on_score_timer_timeout() -> void:
	if washerActive:
		score +=1
		$CanvasLayer/ScoreLabel.text = str(score) + " points"


func _on_washer_press(isActive: bool) -> void:
	if isActive:
		cursor.updateHandSprite("washer_pushed")
		
	washerActive = isActive
	
func _on_serious_appearance_timer_timeout() -> void:
	if serious_time_appearance == 1 and serious_leave_timer.is_stopped():
		serious_appearance_timer.stop()
		serious_time_leave = 3
		serious_leave_timer.start()
		$CanvasLayer/SeriousTimeLabel.text = "Mr. Serious Is Here!"
		return
	serious_time_appearance -= 1
	$CanvasLayer/SeriousTimeLabel.text = "Mr. Serious Appears in \n" + str(serious_time_appearance) + " Seconds"

func _on_serious_leave_timer_timeout() -> void:
	if serious_time_leave == 1 and serious_appearance_timer.is_stopped():
		serious_leave_timer.stop()
		serious_time_appearance = 30
		serious_appearance_timer.start()
		$CanvasLayer/SeriousTimeLabel.text = "Mr. Serious Appears in \n" + str(serious_time_appearance) + " Seconds"
		return
		
	serious_time_leave -= 1
	
func handleGameTime() -> void:
		
	var minutes := int(game_time_in_seconds) / 60
	var seconds := int(game_time_in_seconds) % 60
	
	var time_string = "%02d:%02d" % [minutes, seconds]
	
	$CanvasLayer/GameTimeLabel.text = time_string + ' left'
	
func handlePowerWeight() -> void:
	var powerWeight: int = 0
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
		
func handleLose() -> void:
	if !washerActive and serious_appearance_timer.is_stopped():
		get_tree().paused = true
		reset_button.visible = true
		
func handleWin() -> void:
	if game_time_in_seconds == 0:
		get_tree().paused = true
		reset_button.visible = true
		
		
		
		
		
		
