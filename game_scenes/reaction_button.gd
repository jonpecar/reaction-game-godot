extends Control

class_name  ReactionButton

@onready var button: Button = $MarginContainer/Button
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

@onready var correct: Resource = preload("res://sounds/CorrectDing.mp3")
@onready var incorrect: Resource = preload("res://sounds/Incorrect.wav")
@onready var pop: Resource = preload("res://sounds/Pop.wav")

signal button_pressed(was_lit: bool, time_lit: int)

var is_lit: bool = false
var start_time_msec: int = 0
var input_key: Key = KEY_NONE

func set_key(key: Key) -> void:
	input_key = key
	button.text = char(key)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key_event: InputEventKey = event
		if key_event.pressed and key_event.keycode == input_key:
			_pressed()

func _ready() -> void:
	button.pressed.connect(_pressed)

func _pressed() -> void:
	if is_lit:
		button.remove_theme_stylebox_override("normal")
		button.remove_theme_stylebox_override("hover")
		is_lit = false
		var elapsed_time_msec: int = Time.get_ticks_msec() - start_time_msec
		button_pressed.emit(true, elapsed_time_msec)
		audio.stream = correct
	else:
		button_pressed.emit(false, 0)
		audio.stream = incorrect
	audio.play()

func light_button() -> void:
	is_lit = true
	var style_box: StyleBoxFlat = StyleBoxFlat.new()
	style_box.bg_color = Color8(255, 0, 0)
	button.add_theme_stylebox_override("normal", style_box)
	button.add_theme_stylebox_override("hover", style_box)
	start_time_msec = Time.get_ticks_msec()
	audio.stream = pop
	audio.play()
		
