extends Area2D

@export_multiline var text : String

func _process(_delta):
	$Label.text = text

func _on_body_entered(_body):
	$Label.visible = true


func _on_body_exited(_body):
	$Label.visible = false
