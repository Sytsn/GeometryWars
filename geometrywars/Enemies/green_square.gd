class_name GreenSquare extends CharacterBody2D


@export var speed = 250
@onready var player: Player = $"../Player"

var move_dir: Vector2
var is_moving_away: bool = false


func _physics_process(delta: float) -> void:
	move()


func move():
	if is_moving_away:
		velocity = move_dir * speed
	else:
		move_dir = position.direction_to(player.position)
		velocity = position.direction_to(player.position) * speed
	move_and_slide()
#
#func _on_body_entered(body: Node2D) -> void:
	#body.queue_free()
#
#
#func _on_area_entered(area: Area2D) -> void:
	#die()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.is_dead = true
