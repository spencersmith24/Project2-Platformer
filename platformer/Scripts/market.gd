extends Area2D



func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_obj:
			body.has_obj = false
			print("WINNER")
	else:
		pass
