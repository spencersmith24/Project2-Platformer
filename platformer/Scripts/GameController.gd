extends Node

@onready var player = $"../Player"
@onready var door = $"../lvlObjects/Door"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Door check
	if player.hasKey:
		door.process_mode = PROCESS_MODE_DISABLED
