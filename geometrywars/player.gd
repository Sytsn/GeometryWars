class_name Player extends CharacterBody2D

@export var speed = 350
@export var rot_speed = 10
@export var fire_rate = 0.1
@export var bullet_array: Array[PackedScene]

@onready var pivot: Node2D = $Pivot
@onready var mesh: Sprite2D = $CollisionShape2D/Boat
@onready var bullet: PackedScene = preload("res://Bullets/DoubleBullet.tscn")
@onready var world = $"../"
@onready var shoot_timer: Timer = $ShootTimer  # Add Timer node as child
@onready var death_menu = $DeathMenu
@onready var points_label = $Points

var shoot_cooldown = 0.0
var is_dead: bool = false


func _process(delta: float) -> void:
	points_label.text = str(Global.points)


func _physics_process(delta: float) -> void:
	if is_dead:
		death_menu.visible = true
		death_menu.points.text = str(Global.points)
		return
	shoot_cooldown = max(0, shoot_cooldown - delta)  # Count down
	get_input(delta)
	move_and_slide()
	shoot()

func get_input(delta: float):
	pivot.look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	mesh.rotation = input_direction.angle() + deg_to_rad(90)
	velocity = input_direction * speed

func shoot():
	if shoot_cooldown > 0:
		return
	var bullet_type
	if Global.points < 2000:
		bullet_type = bullet_array[0] 
	else:
		bullet_type = bullet_array[1] 
		
	
	var instance = bullet_type.instantiate()
	world.add_child(instance)
	instance.global_position = pivot.global_position
	instance.rotation = pivot.rotation
	
	shoot_cooldown = fire_rate  # Reset cooldown


func _on_player_aim_body_entered(body: Node2D) -> void:
	if body is GreenSquare:
		body.move_dir = position.direction_to(body.position).orthogonal()
		body.is_moving_away = true
		body.speed = 250


func _on_player_aim_body_exited(body: Node2D) -> void:
	body.is_moving_away = false
	body.speed = 200
