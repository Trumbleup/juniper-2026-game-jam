extends Node2D

@onready var red_lights = $RedLights
@onready var green_lights = $GreenLights


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_game_total_power_weight_change(score: int) -> void:
	if score >= 7: 
		red_lights.visible = false
		green_lights.visible = true
	else:
		red_lights.visible = true
		green_lights.visible = false
		
