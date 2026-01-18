class_name Diamond extends Enemy


@export var speed = 100
@onready var player: Player = $"../Player"


func _physics_process(delta: float) -> void:
	print(player)
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
