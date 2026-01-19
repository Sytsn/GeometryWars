class_name Diamond extends Enemy


@export var speed = 100
@onready var player: Player = $"../Player"


func _ready() -> void:
	point_value = 100


func _physics_process(delta: float) -> void:
	move()


func move():
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
