extends Node2D


@onready var diamond_scene: PackedScene = preload("res://Enemies/Diamond.tscn")
@onready var fan_scene: PackedScene = preload("res://Enemies/FanBlade.tscn")
@onready var square_scene: PackedScene = preload("res://Enemies/green_square.tscn")

@onready var spawn_timer: Timer = $SpawnTimer  

@export var spawn_points: Array[Node2D]
@export var can_spawn_diamond: bool = true


var wave_spawn_cooldown := 0.0
var wave_spawn_rate := 1
var spawn_cooldown := 0.0
var spawn_rate := .1
var index: int = 0
var diamond_count: int = 0
var wave: int = 1


func _ready() -> void:
	get_tree().paused = true
	Global.points = 0


func _process(delta: float) -> void:
	spawn_cooldown = max(0, spawn_cooldown - delta)
	wave_spawn_cooldown = max(0, wave_spawn_rate - delta)
	
	if wave_spawn_cooldown > 0:
		return
	else:
		spawn_wave()


func spawn_diamond():
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
	
	
func spawn_fan():
	if spawn_cooldown > 0:
		return
		
	var instance = fan_scene.instantiate()
	add_child(instance)
	instance.global_position = spawn_points[index].global_position
	index += 1
	spawn_cooldown = spawn_rate  


func spawn_gree_sqaure():
	if spawn_cooldown > 0:
		return
		
	var instance = square_scene.instantiate()
	add_child(instance)
	instance.global_position = spawn_points[index].global_position
	index += 1
	if index > 8 :
		index = 5
	spawn_cooldown = spawn_rate  


func spawn_wave():
	var i: int = 0
	while i < wave * 2:
		spawn_diamond()
		i += 1
	
	while i < wave * 5:
		spawn_fan()
		i += 1
	
	if wave > 3:
		while i < wave + 4:
			index = 5
			spawn_gree_sqaure()
			i += 1
	wave += 1
