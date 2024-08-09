extends Control

@onready var button: Button = $MarginContainer/VBoxContainer/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_start_game)
	
func _start_game() -> void:
	LevelManager.start_game(self)
