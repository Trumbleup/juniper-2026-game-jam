extends Node2D

var score: int
var washerActive: bool = false
@export var entityHeld: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_score_timer_timeout() -> void:
	if washerActive:
		score +=1
		$CanvasLayer/ScoreLabel.text = str(score) + " points"


func _on_washer_press(isActive: bool) -> void:
	washerActive = isActive
