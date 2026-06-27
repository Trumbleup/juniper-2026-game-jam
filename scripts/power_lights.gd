extends Node2D

var red_dim = $"Red Dim"
var green_dim = $"Green Dim"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_total_power_weight_change(score: int) -> void:
	if score >= 7:
		
