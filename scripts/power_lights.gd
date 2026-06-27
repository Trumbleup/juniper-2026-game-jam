extends Node2D

@onready var red_lights = $RedLights
@onready var green_lights = $GreenLights

@onready var grouped_green_lights = get_tree().get_nodes_in_group("green_lights")
@onready var grouped_red_lights = get_tree().get_nodes_in_group("red_lights")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_game_total_power_weight_change(score: int) -> void:
	var difference: int
	var green_max: int = 10
	var red_max: int = 6
	if score >= 7: 
		red_lights.visible = false
		green_lights.visible = true
		difference = green_max - score
		
		for i in green_max:
			if i < difference:	
				grouped_green_lights[i].visible = false
			else:
				grouped_green_lights[i].visible = true
		
		
	else:
		red_lights.visible = true
		green_lights.visible = false
		difference = red_max - score
		
		for i in red_max:
			if i < difference:	
				grouped_red_lights[i].visible = false
			else:
				grouped_red_lights[i].visible = true
		
