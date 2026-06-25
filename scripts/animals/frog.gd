extends Animal

@export var score_weight: int = 2

const SPEED: int = 100

func _process(delta: float) -> void:
	handleMovement(delta, SPEED)
