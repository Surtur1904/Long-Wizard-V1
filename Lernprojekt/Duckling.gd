extends Area2D

func _on_body_entered(body):
	if (body.name == "Donnie"):
		get_tree().change_scene_to_file("res://Scenes/Level2.tscn")
