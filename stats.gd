extends Node

const MS_PER_MISCLICK = 500

var current_time: int = 0
var misclicks: int = 0

var best_score: int = 1_000_000_000

func finalise_score() -> int:
	var final_score: int = current_time + (misclicks * MS_PER_MISCLICK)
	if final_score < best_score:
		best_score = final_score
	return final_score

func clear_current_score() -> void:
	current_time = 0
	misclicks = 0
