extends Control

@onready var time: Label = $CenterContainer/VBoxContainer/GridContainer/TimeLabel
@onready var misclick: Label = $CenterContainer/VBoxContainer/GridContainer/MisclickLabel
@onready var score: Label = $CenterContainer/VBoxContainer/GridContainer/ScoreLabel
@onready var best: Label = $CenterContainer/VBoxContainer/GridContainer/BestLabel
@onready var best_banner: Label = $CenterContainer/VBoxContainer/BestTimeLabel
@onready var button: Button = $CenterContainer/VBoxContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var my_score: int = Stats.finalise_score()
	time.text = str(Stats.current_time)
	misclick.text = str(Stats.misclicks)
	score.text = str(my_score)
	best.text = str(Stats.best_score)
	if Stats.best_score != my_score:
		best_banner.hide()
	button.pressed.connect(_start_game)

func _start_game() -> void:
	LevelManager.start_game(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
