extends Node2D


@onready var diamond_scene: PackedScene = preload("res://Enemies/Diamond.tscn")
@onready var spawn_timer: Timer = $SpawnTimer  

@export var spawn_points: Array[Node2D]
@export var can_spawn_diamond: bool = true

var spawn_cooldown := 0.0
var spawn_rate := 0.1
var index: int = 0
var diamond_count: int = 0


func _process(delta: float) -> void:
	spawn_cooldown = max(0, spawn_cooldown - delta)
	spawn_diamond()
	
	
	
func spawn_diamond():
	if !can_spawn_diamond or diamond_count > 25:
		return
		
	if spawn_cooldown > 0:
		return
		
	var instance = diamond_scene.instantiate()
	add_child(instance)
	instance.global_position = spawn_points[index].global_position
	index += 1
	diamond_count += 1
	if index >= 4:
		index = 0
	spawn_cooldown = spawn_rate  
