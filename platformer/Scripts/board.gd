extends Area2D

@export var text = "placeholder"

func _process(delta):
	$Label.text = text


func _on_body_entered(body):
	$Label.visible = true


func _on_body_exited(body):
	$Label.visible = false
