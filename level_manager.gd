extends Node

const start_menu: Resource = preload("res://start_menu.tscn")
const game_scene: Resource = preload("res://game_scenes/basic_game.tscn")
const end_game: Resource = preload("res://game_scenes/score_screen.tscn")
const side_scroll: Resource = preload("res://side_scrolling_scenes/main_side_scene.tscn")

# in future - difficulty etc.
func start_game(current_scene: Node) -> void:
	var new_scene: Node = game_scene.instantiate()
	_replace_current_scene(new_scene, current_scene)
	new_scene.start_game.call_deferred()

func finish_game(current_scene: Node) -> void:
	var new_scene: Node = end_game.instantiate()
	_replace_current_scene(new_scene, 	current_scene)
	
func _replace_current_scene(new_scene: Node, current_scene: Node) -> void:
	var root: Window = get_tree().root
	root.remove_child.call_deferred(current_scene)
	current_scene.queue_free()
	root.add_child.call_deferred(new_scene)
	get_tree().paused = false #New scene always starts unpaused. If it needs to start paused it can do it itself

func start_side_scroll(current_scene: Node) -> void:
	var new_scene: Node = side_scroll.instantiate()
	_replace_current_scene(new_scene, current_scene)

func back_to_start(current_scene: Node) -> void:
	var new_scene: Node = start_menu.instantiate()
	_replace_current_scene(new_scene, current_scene)
