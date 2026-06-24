extends Animal

const SPEED: int = 150

func _process(delta: float) -> void:
	handleDragging()
	handleMovement(delta, SPEED)
