extends StaticBody2D


func _on_bottom_wall_body_entered(body: Node2D) -> void:
	if body is FanBlade:
		body.move_dir.y = -body.move_dir.y


func _on_left_wall_body_entered(body: Node2D) -> void:
	if body is FanBlade:
		body.move_dir.x = -body.move_dir.x


func _on_top_wall_body_entered(body: Node2D) -> void:
	if body is FanBlade:
		body.move_dir.y = -body.move_dir.y


func _on_right_wall_body_entered(body: Node2D) -> void:
	if body is FanBlade:
		body.move_dir.x = -body.move_dir.x
