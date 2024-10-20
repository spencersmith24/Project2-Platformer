extends Area2D

@export var speed = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent() is PathFollow2D:
		follow_path(delta)


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.collide_with_enemy()
		

func follow_path(delta):
	$"..".progress_ratio += delta * speed
	
	if $"..".progress_ratio > .5:
		scale.x = 1
	else:
		scale.x = -1
