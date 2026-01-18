extends CharacterBody2D

@export var speed = 400
@export var rot_speed = 10

@onready var pivot: Node2D = $Pivot
@onready var mesh: MeshInstance2D = $MeshInstance2D

func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()


func get_input(delta: float):
	pivot.look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	mesh.rotation = input_direction.angle()
	
	#mesh.rotation = lerp_angle(rotation, input_direction.angle(), rot_speed * delta)
	velocity = input_direction * speed
