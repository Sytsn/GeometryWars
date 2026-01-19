extends Node2D

@export var bullets: Array[Bullet]


func _ready() -> void:
	for bullet in bullets:
		bullet.speed = 1100
