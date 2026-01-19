extends Control


@onready var points = $Points

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


func _on_quit_to_menu_pressed() -> void:
	get_tree().reload_current_scene()
