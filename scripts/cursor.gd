extends Node2D

@onready var OpenHandSprite = $HandSprites/OpenHand
@onready var PointedHandSprite = $HandSprites/PointedHand
@onready var PushedHandSprite = $HandSprites/PushedHand
@onready var GrabbedHandSprite = $HandSprites/GrabbedHand

@onready var action_states = {
	"hand_open": OpenHandSprite,
	"hover_washer": PointedHandSprite,
	"washer_pushed": PushedHandSprite,
	"animal_grabbed": GrabbedHandSprite,
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(_delta: float) -> void:
	update_marker()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	

func update_marker() -> void:
	var mouse_local_pos: Vector2 = get_local_mouse_position()
	$HandSprites.position = mouse_local_pos
	
func updateHandSprite(action: String) -> void:
	OpenHandSprite.visible = false
	PointedHandSprite.visible = false
	PushedHandSprite.visible = false
	GrabbedHandSprite.visible = false
	
	action_states[action].visible = true
	
	
