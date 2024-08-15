extends Control

@onready var button: Button = $MarginContainer/VBoxContainer/Button
@onready var side_button: Button = $MarginContainer/VBoxContainer/Button2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.pressed.connect(_start_game)
	side_button.pressed.connect(_start_side_scroll)

func _start_side_scroll() -> void:
	LevelManager.start_side_scroll(self)

func _start_game() -> void:
	LevelManager.start_game(self)
