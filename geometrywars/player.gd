extends CharacterBody2D

@export var speed = 400
@export var rot_speed = 10
@export var fire_rate = 0.15  # Bullets per second (12.5 bullets/sec)

@onready var pivot: Node2D = $Pivot
@onready var mesh: MeshInstance2D = $MeshInstance2D
@onready var bullet: PackedScene = preload("res://bullet.tscn")
@onready var world = $"../"

var can_shoot = true


func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()
	shoot()

func get_input(delta: float):
	pivot.look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	mesh.rotation = input_direction.angle()
	
	#mesh.rotation = lerp_angle(rotation, input_direction.angle(), rot_speed * delta)
	velocity = input_direction * speed


func shoot():
	if not can_shoot:
		return
		
	var instance = bullet.instantiate()
	world.add_child(instance)
	instance.global_position = pivot.global_position
	instance.rotation = pivot.rotation
	
	can_shoot = false
	await get_tree().create_timer(fire_rate).timeout
	can_shoot = true
