extends Control

var reaction_button: Resource = preload("res://reaction_button.tscn")

@onready var grid: GridContainer = $VBoxContainer/GridContainer
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var time_label: Label = $VBoxContainer/HBoxContainer/TimeValue
@onready var wrong_label: Label = $VBoxContainer/HBoxContainer/WrongValue

const TOTAL_NUMBER_TRIES = 5
const MIN_S_BEFORE = 0.3
const MAX_S_BEFORE = 1.5

var next_button_timer: Timer = null
var total_button_press: int = 0
var total_time_ms: int = 0
var incorrect_presses: int = 0

func update_score() -> void:
	time_label.text = str(total_time_ms)
	wrong_label.text = str(incorrect_presses)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(9):
		var new_button: Control = reaction_button.instantiate()
		grid.add_child(new_button)
		new_button.button_pressed.connect(button_pressed)
	start_game()

func get_buttons() -> Array[ReactionButton]:
	var buttons: Array[ReactionButton] = []
	buttons.assign(grid.get_children().filter(func(n: Node) -> bool: return n is ReactionButton))
	return buttons
	
func button_pressed(was_lit: bool, time: int) -> void:
	if was_lit:
		total_button_press += 1
		total_time_ms += time
		start_next_button()
	else:
		incorrect_presses += 1
	update_score()

func start_game() -> void:
	rng.randomize()
	total_button_press = 0
	total_time_ms = 0
	incorrect_presses = 0
	update_score()
	start_next_button()

	
func start_next_button() -> void:
	if total_button_press > TOTAL_NUMBER_TRIES:
		return
	if next_button_timer:
		next_button_timer.queue_free()
	var buttons: Array = get_buttons()
	var selected_button_num: int = rng.randi_range(1, len(buttons))
	var selected_button: ReactionButton = buttons[selected_button_num - 1]
	print(selected_button_num)
	next_button_timer = Timer.new()
	add_child(next_button_timer)
	next_button_timer.timeout.connect(selected_button.light_button)
	next_button_timer.start(rng.randf_range(MIN_S_BEFORE, MAX_S_BEFORE))
	next_button_timer.one_shot = true
