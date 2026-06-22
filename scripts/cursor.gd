extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	update_marker()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	

func update_marker() -> void:
	var mouse_local_pos: Vector2 = get_local_mouse_position()
	$Marker.position = mouse_local_pos
