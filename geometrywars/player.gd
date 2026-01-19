class_name Player extends CharacterBody2D

@export var speed = 350
@export var rot_speed = 10
@export var fire_rate = 0.1

@onready var pivot: Node2D = $Pivot
@onready var mesh: MeshInstance2D = $CollisionShape2D/MeshInstance2D
@onready var bullet: PackedScene = preload("res://Bullets/DoubleBullet.tscn")
@onready var world = $"../"
@onready var shoot_timer: Timer = $ShootTimer  # Add Timer node as child
@onready var dead_label = $Label

var shoot_cooldown = 0.0

var is_dead: bool = false


func _physics_process(delta: float) -> void:
	if is_dead:
		dead_label.visible = true
	shoot_cooldown = max(0, shoot_cooldown - delta)  # Count down
	get_input(delta)
	move_and_slide()
	shoot()

func get_input(delta: float):
	pivot.look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	mesh.rotation = input_direction.angle()
	velocity = input_direction * speed

func shoot():
	if shoot_cooldown > 0:
		return
		
	var instance = bullet.instantiate()
	world.add_child(instance)
	instance.global_position = pivot.global_position
	instance.rotation = pivot.rotation
	
	shoot_cooldown = fire_rate  # Reset cooldown


func _on_player_aim_body_entered(body: Node2D) -> void:
	if body is GreenSquare:
		body.move_dir = position.direction_to(body.position).orthogonal()
		body.is_moving_away = true
		body.speed = 350


func _on_player_aim_body_exited(body: Node2D) -> void:
	body.is_moving_away = false
	body.speed = 200
