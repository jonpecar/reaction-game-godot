extends Control

class_name  ReactionButton

@onready var button: Button = $MarginContainer/Button

signal button_pressed(was_lit: bool, time_lit: int)

var is_lit: bool = false
var start_time_msec: int = 0

func _ready() -> void:
	button.pressed.connect(_pressed)

func _pressed() -> void:
	if is_lit:
		button.remove_theme_stylebox_override("normal")
		button.remove_theme_stylebox_override("hover")
		is_lit = false
		var elapsed_time_msec: int = Time.get_ticks_msec() - start_time_msec
		button_pressed.emit(true, elapsed_time_msec)
	else:
		button_pressed.emit(false, 0)

func light_button() -> void:
	is_lit = true
	var style_box: StyleBoxFlat = StyleBoxFlat.new()
	style_box.bg_color = Color8(255, 0, 0)
	button.add_theme_stylebox_override("normal", style_box)
	button.add_theme_stylebox_override("hover", style_box)
	start_time_msec = Time.get_ticks_msec()
