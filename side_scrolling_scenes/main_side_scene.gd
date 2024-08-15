extends Node2D

func _input(event: InputEvent) -> void:
	if event.is_action("ui_cancel"):
		LevelManager.back_to_start(self)
