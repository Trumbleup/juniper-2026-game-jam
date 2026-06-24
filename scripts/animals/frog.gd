extends Animal

@export var score_weight: int = 2

const SPEED: int = 150

func _process(delta: float) -> void:
	handleDragging()
	handleMovement(delta, SPEED)
