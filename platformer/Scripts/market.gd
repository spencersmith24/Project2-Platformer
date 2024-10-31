extends Area2D

@export_multiline var text : String

var txtVisibility = false

func _process(_delta):
	$Label.visible = txtVisibility
	$Label.text = text
