extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ParallaxBackground/Clouds_1.motion_offset.x -= -15 * delta
	$ParallaxBackground/Clouds_2.motion_offset.x += -30 * delta
	
	if Input.is_action_just_pressed("continue"):
		get_tree().change_scene_to_file("res://Scenes/level1.tscn")
