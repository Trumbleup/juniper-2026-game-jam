extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if "animalType" in body:
		body.isOnGround = true


func _on_body_exited(body: Node2D) -> void:
	if "animalType" in body:
		body.isOnGround = false
