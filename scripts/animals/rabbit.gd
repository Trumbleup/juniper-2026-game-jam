extends Animal

@export var score_weight: int = 1

const SPEED: int = 150

func _process(delta: float) -> void:
	handleMovement(delta, SPEED)
