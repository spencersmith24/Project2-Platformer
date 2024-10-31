extends Node

@onready var PLAYER = $"../Player"
@onready var BARRIER = $"../lvlObjects/Barrier"
@onready var GAME_AXE =  $"../lvlObjects/Axe"
@onready var GAME_DJ =  $"../lvlObjects/DoubleJumpItem"
@onready var GAME_OBJ = $"../lvlObjects/Pumpkin"
@onready var HIDDEN_LAYER = $"../TileMapLayers/HiddenLayer"
@onready var GAME_MARKET = $"../lvlObjects/Market"
@onready var PLAYER_START_POS = PLAYER.position

# Checkpoint variables
var has_checkpoint = false
@onready var checkpoint_pos = GAME_OBJ.position

@export var canContinue = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	can_continue_check()
	obj_check()

func reset_level():
	if has_checkpoint == false:
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
	else:
		PLAYER.position = checkpoint_pos

func obj_check():
	if PLAYER.has_obj:
		HIDDEN_LAYER.process_mode = Node.PROCESS_MODE_DISABLED
		HIDDEN_LAYER.visible = false
		HIDDEN_LAYER.collision_enabled = false
		has_checkpoint = true
		$"../Lamp".get_node("lanternLit").visible = true
		$"../Lamp".get_node("lantern").visible = false
		
func _on_btm_bndry_body_entered(_body):
	reset_level()


func _on_market_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_obj:
			GAME_MARKET.txtVisibility = true
			body.has_obj = false
			canContinue = true
	else:
		GAME_MARKET.txtVisibility = false

func can_continue_check():
	if Input.is_action_just_pressed("continue") and canContinue:
		get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
		canContinue = false
