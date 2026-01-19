class_name Bullet extends Node2D


var speed = 800
var lifetime = 2.0


func _physics_process(delta):
	position += transform.x * speed * delta
	lifetime -= delta
	if lifetime <= 0:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Enemy:
		Global.points += body.point_value
	body.queue_free()
