extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("continue"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
	$ParallaxBackground/Clouds_1.motion_offset.x -= -15 * delta
	$ParallaxBackground/Clouds_2.motion_offset.x += -30 * delta
	$UI/Title.position.y -= 1
	
