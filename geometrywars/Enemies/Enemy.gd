class_name Enemy extends CharacterBody2D

@export var point_value = 0


func move():
	pass


func die():
	queue_free()
