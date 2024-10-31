extends Area2D

@export_multiline var text : String

@export var canContinue = false

func _process(_delta):
	$Label.text = text
	
	if Input.is_action_just_pressed("continue") and canContinue:
		print("WINNER")
		canContinue = false

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_obj:
			$Label.visible = true
			body.has_obj = false
			canContinue = true
	else:
		$Label.visible = false
		pass
