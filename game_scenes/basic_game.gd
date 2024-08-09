extends Control

var reaction_button: Resource = preload("res://game_scenes/reaction_button.tscn")

@onready var grid: GridContainer = $VBoxContainer/GridContainer
@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var time_label: Label = $VBoxContainer/HBoxContainer/TimeValue
@onready var wrong_label: Label = $VBoxContainer/HBoxContainer/WrongValue

const TOTAL_NUMBER_TRIES = 5
const MIN_S_BEFORE = 0.3
const MAX_S_BEFORE = 1.5

var next_button_timer: Timer = null
var total_button_press: int = 0
var game_running: bool = false

var keys: Array[Key] = [KEY_Q, KEY_W, KEY_E, KEY_A, KEY_S, KEY_D, KEY_Z, KEY_X, KEY_C]

func update_score() -> void:
	time_label.text = str(Stats.current_time)
	wrong_label.text = str(Stats.misclicks)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for key in keys:
		var new_button: ReactionButton = reaction_button.instantiate()
		grid.add_child(new_button)
		new_button.button_pressed.connect(button_pressed)
		new_button.set_key(key)

func get_buttons() -> Array[ReactionButton]:
	var buttons: Array[ReactionButton] = []
	buttons.assign(get_tree().get_nodes_in_group("button"))
	return buttons
	
func button_pressed(was_lit: bool, time: int) -> void:
	if not game_running:
		return
	if was_lit:
		total_button_press += 1
		Stats.current_time += time
		start_next_button()
	else:
		Stats.misclicks += 1
	update_score()

func start_game() -> void:
	rng.randomize()
	total_button_press = 0
	Stats.clear_current_score()
	update_score()
	start_next_button()
	game_running = true

	
func start_next_button() -> void:
	if total_button_press > TOTAL_NUMBER_TRIES:
		game_running = false
		LevelManager.finish_game(self)
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
