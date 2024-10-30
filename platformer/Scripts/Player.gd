extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

@onready var START_POS = self.position
@onready var GAME_CONTROLLER = $"../GameController"
@onready var GAME_AXE = $"../lvlObjects/Axe"
@onready var GAME_DJ = $"../lvlObjects/DoubleJumpItem"
@onready var GAME_OBJ = $"../lvlObjects/Pumpkin"
@onready var anim_tree = $AnimationTree

# These are exports for testing reasons
@export var has_axe = false
@export var has_flag = false
@export var extra_jump = false

var can_climb = false
var num_jumps = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.15

func _process(_delta):
	
	# Handle walking/idle
	if abs(velocity.x) > .1 :
		anim_tree.set("parameters/conditions/idle", false)
		anim_tree.set("parameters/conditions/walk", true)
	else:
		anim_tree.set("parameters/conditions/idle", true)
		anim_tree.set("parameters/conditions/walk", false)
	
	
	if(velocity.x > 0):
		$Sprite2D.scale.x = 1
	elif (velocity.x < 0):
		$Sprite2D.scale.x = -1
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		anim_tree.set("parameters/conditions/jump", false)
		if is_on_floor() or (num_jumps < 1 and extra_jump):
			velocity.y = JUMP_VELOCITY
			anim_tree.set("parameters/conditions/jump", true)
			num_jumps += 1 if not is_on_floor() else 0
		else:
			anim_tree.set("parameters/conditions/jump", false)
	else:
		anim_tree.set("parameters/conditions/jump", false)

	
	if is_on_floor():
		num_jumps = 0
	
	if is_on_floor():
		num_jumps = 0
	
	# Handle Climb
	if Input.is_action_pressed("climb") and can_climb:
		velocity.y = SPEED * -.5
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("walk_L", "walk_R")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# Handle attack
	if Input.is_action_just_pressed("attack") and has_axe:
		anim_tree.set("parameters/conditions/attack", true)
	else:
		anim_tree.set("parameters/conditions/attack", false)



# Pick stuff up
func pick_up_axe():
	if has_axe == false:
		has_axe = true
		GAME_AXE.call_deferred("set_disable_mode", true)
		GAME_AXE.visible = false

func pick_up_bread():
	extra_jump = true
	GAME_DJ.call_deferred("set_disable_mode", true)
	GAME_DJ.visible = false

func pick_up_flag():
	has_flag = true
	GAME_OBJ.call_deferred("set_disable_mode", true)
	GAME_OBJ.visible = false

# Ladder Climbing
func _on_ladder_area_body_entered(body):
	if body == self:
		can_climb = true


func _on_ladder_area_body_exited(body):
	if body == self:
		can_climb = false

# Hitting enemy
func collide_with_enemy():
	GAME_CONTROLLER.reset_level()
	
	#TODO: reduce lives when hit.


func _on_attack_area_body_entered(body):
	if body.is_in_group("Obstacles"):
		body.process_mode = PROCESS_MODE_DISABLED
		body.modulate.a = 0.25
		#TODO: change it so you must attack barrier to get through
