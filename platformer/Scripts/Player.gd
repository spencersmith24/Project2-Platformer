extends CharacterBody2D

@onready var START_POS = self.position
@onready var GAME_CONTROLLER = $"../GameController"
@onready var GAME_KEY = $"../lvlObjects/Key"
@onready var GAME_BREAD = $"../lvlObjects/DJBread"

const SPEED = 200.0

var extra_jump = false

var num_jumps = 0

var hasKey = false
var canClimb = false


const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 1.15

func _process(delta):
	
	if abs(velocity.x) > .1 and $AnimatedSprite2D.animation != "walk" and hasKey == false:
		$AnimatedSprite2D.play("walk")
	elif abs(velocity.x) > .1 and $AnimatedSprite2D.animation != "walk" and hasKey == true:
		$AnimatedSprite2D.play("walk_key")
	elif abs(velocity.x) < .1 and $AnimatedSprite2D.animation != "idle" and hasKey == false:
		$AnimatedSprite2D.play("idle")
	elif abs(velocity.x) < .1 and $AnimatedSprite2D.animation != "idle" and hasKey == true:
		$AnimatedSprite2D.play("idle_key")
		
		
	if(velocity.x > 0):
		$AnimatedSprite2D.scale.x = -1
	elif (velocity.x < 0):
		$AnimatedSprite2D.scale.x = 1
		
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and num_jumps < 1 and extra_jump == true:
		velocity.y = JUMP_VELOCITY
		num_jumps += 1
	elif Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_on_floor():
		num_jumps = 0
	print(num_jumps)
	
	# Handle Climb
	if Input.is_action_pressed("climb") and canClimb:
		velocity.y = SPEED * -.5

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("walk_L", "walk_R")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func pick_up_key():
	if hasKey == false:
		hasKey = true
		GAME_KEY.process_mode = Node.PROCESS_MODE_DISABLED
		GAME_KEY.visible = false

func pick_up_bread():
	extra_jump = true
	GAME_BREAD.process_mode = Node.PROCESS_MODE_DISABLED
	GAME_BREAD.visible = false

# Ladder Climbing
func _on_ladder_area_body_entered(body):
	if body == self:
		canClimb = true


func _on_ladder_area_body_exited(body):
	if body == self:
		canClimb = false

# Hitting enemy
func collide_with_enemy():
	GAME_CONTROLLER.reset_level()
	
	#TODO: reduce lives when hit.
