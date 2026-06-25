extends Animal

@export var score_weight: int = 1

const SPEED: int = 200

func _process(delta: float) -> void:
	handleDragging()
	handleMovement(delta, SPEED)
