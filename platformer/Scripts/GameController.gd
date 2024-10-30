extends Node

@onready var PLAYER = $"../Player"
@onready var BARRIER = $"../lvlObjects/Barrier"
@onready var GAME_AXE =  $"../lvlObjects/Axe"
@onready var GAME_DJ =  $"../lvlObjects/DoubleJumpItem"
@onready var GAME_OBJ = $"../lvlObjects/Pumpkin"
@onready var HIDDEN_LAYER = $"../TileMapLayers/HiddenLayer"
@onready var PLAYER_START_POS = PLAYER.position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#barrier_check()
	obj_check()
		
func reset_level():
	PLAYER.has_axe = false
	PLAYER.has_obj = false
	PLAYER.extra_jump = false
	PLAYER.position = PLAYER_START_POS
	
	HIDDEN_LAYER.process_mode = Node.PROCESS_MODE_INHERIT
	HIDDEN_LAYER.visible = true
	HIDDEN_LAYER.collision_enabled = true
	
	GAME_AXE.process_mode = Node.PROCESS_MODE_INHERIT
	GAME_AXE.visible = true
	
	BARRIER.process_mode = PROCESS_MODE_INHERIT
	BARRIER.modulate.a = 1
	
	GAME_DJ.process_mode = Node.PROCESS_MODE_INHERIT
	GAME_DJ.visible = true
	
	GAME_OBJ.process_mode = Node.PROCESS_MODE_INHERIT
	GAME_OBJ.visible = true

func barrier_check():
	if PLAYER.has_axe:
		BARRIER.process_mode = PROCESS_MODE_DISABLED
		BARRIER.modulate.a = 0.25
	else:
		BARRIER.process_mode = PROCESS_MODE_INHERIT
		BARRIER.modulate.a = 1


func obj_check():
	if PLAYER.has_obj:
		HIDDEN_LAYER.process_mode = Node.PROCESS_MODE_DISABLED
		HIDDEN_LAYER.visible = false
		HIDDEN_LAYER.collision_enabled = false


func _on_flag_area_body_entered(body):
	if body.is_in_group("Player") and PLAYER.has_flag:
		PLAYER.has_flag = false
		HIDDEN_LAYER.process_mode = Node.PROCESS_MODE_INHERIT
		HIDDEN_LAYER.visible = true
		print("WINNER WINNER CHICKEN DINNER")

func _on_btm_bndry_body_entered(_body):
	reset_level()
