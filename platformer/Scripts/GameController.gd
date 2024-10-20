extends Node

@onready var PLAYER = $"../Player"
@onready var DOOR = $"../lvlObjects/Door"
@onready var GAME_KEY =  $"../lvlObjects/Key"
@onready var GAME_BREAD =  $"../lvlObjects/DJBread"
@onready var PLAYER_START_POS = PLAYER.position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	door_check()

func reset_level():
	PLAYER.hasKey = false
	PLAYER.extra_jump = false
	PLAYER.position = PLAYER_START_POS
	GAME_KEY.process_mode = Node.PROCESS_MODE_INHERIT
	GAME_KEY.visible = true
	GAME_BREAD.process_mode = Node.PROCESS_MODE_INHERIT
	GAME_BREAD.visible = true

func door_check():
	if PLAYER.hasKey:
		DOOR.process_mode = PROCESS_MODE_DISABLED
	else:
		DOOR.process_mode = PROCESS_MODE_INHERIT
