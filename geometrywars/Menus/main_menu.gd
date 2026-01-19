extends Control


func _on_play_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()
